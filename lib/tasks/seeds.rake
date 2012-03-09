namespace :seed do  
  
  require 'csv'
  require 'open-uri'
  require 'highline/import'
  
  # all the keys
  @@nyt_api_key_2 = '4e8aa4d7b091d796aca565dbebf31404:9:65704848' # alan's
  @@nyt_api_key = 'b16efb69e13af05498fe536551a7bc67:15:65673083' # dustin's
  @@sunlight_api_key = '5cdbb43c42d84ef3b4bde09efa074648'
  @@open_secrets_api_key = '3c994a55a6b79f30f22b6b3942941f62'
  
  # top level lists 
  @@house_members = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/house/members.xml?api-key=#{@@nyt_api_key}"
  @@senate_members = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/senate/members?api-key=#{@@nyt_api_key}"
  
  desc "Add net worth to members of congress"
  task :net_worth => :environment do
    csv = "/Users/alan/sites/politics411/PFD/crp_data.csv"
    puts "Loading csv of net worths from #{csv}..."
    
    CSV.foreach(csv) do |row|
      if Person.find_by_crp_id(row[0]).nil?
        puts "skipping #{row[1]}, not in database!"
      else
        @person = Person.find_by_crp_id(row[0])
        @person.net_worth_minimum = row[2]
        @person.net_worth_maximum = row[3]
        @person.net_worth_average = row[4]
        if @person.save
          puts "Net worth saved for #{@person.first_name} #{@person.last_name}"
        else 
          puts "Something went wrong!!!"
        end
      end
    end
  end
  
  desc "Add earmarks to members of congress"
  task :earmarks => :environment do
    earmark_csv = "/Users/alan/sites/politics411/earmarks/earmark.csv"
    member_csv = "/Users/alan/sites/politics411/earmarks/member.csv"
    recipient_csv = "/Users/alan/sites/politics411/earmarks/recipient.csv"
    
    puts "Loading earmarks from csv..."
    CSV.foreach(earmark_csv) do |row|
      @earmark = Earmark.new(
        :csv_earmark_id => row[0],
        :import_reference_id => row[1],
        :fiscal_year => row[2],
        :budget_amount => row[3],
        :house_amount => row[4],
        :senate_amount => row[5],
        :omni_amount => row[6],
        :final_amount => row[7],
        :bill => row[8],
        :bill_section => row[9],
        :bill_subsection => row[10],
        :description => row[11],
        :notes => row[12],
        :presidential => row[13],
        :undisclosed => row[14],
        :house_members => row[15],
        :house_parties => row[16],
        :house_states => row[17],
        :house_districts => row[18],
        :senate_members => row[19],
        :senate_parties => row[20],
        :senate_states => row[21]
        )
      
      if @earmark.save
        puts "Earmark #{row[0]} saved!"
      else
        puts "Earmark #{row[0]} failed to save!"
      end
    end
    
    puts "Mapping members from csv to earmarks..."
    CSV.foreach(member_csv) do |row|
      if Person.find_by_crp_id(row[3]).blank?
        puts "No record found for #{row[2]}, skipping!"
        @person_id = Person.find_by_crp_id(row[3]).id
        @earmark = Earmark.find_by_csv_earmark_id(row[1])
        @earmark.person_id = @person_id
        
        if @earmark.save
          puts "#{@person_id} mapped to earmark ##{row[1]}!"
        else
          puts "Something went wrong with earmark ##{row[1]}!"
        end
      end
    end
    
    puts "Mapping recipients from csv to earmarks..."
    CSV.foreach(recipient_csv) do |row|
      if Earmark.find_by_csv_earmark_id(row[1]).blank?
        puts "couldn't find earmark with the id of #{row[1]}"
      else
        @earmark = Earmark.find_by_csv_earmark_id(row[1])
        @earmark.recipient = row[2]
        if @earmark.save
          puts "Recipient #{row[2]} mapped to earmark #{row[1]}!"
        else
          puts "There was a problem saving earmark #{row[1]}!"
        end
      end
    end  
    puts "All done, success."    
  end
  
  desc "Add assets to members of congress"
  task :assets => :environment do
    puts "Making a list of everyone in the database..."
    @people = Person.all
    @crp_ids = []
    @people.each do |p|
      @crp_ids << p.crp_id
    end
    
    csv = "/Users/alan/sites/politics411/PFD/PFDasset.txt"
    CSV.foreach(csv) do |row|
      @crp = row[2].gsub("|", "")
      
    end
    
    @crp_ids.each do |crp|
      if crp.blank?
        puts "Entry blank, skipping!"
      else
        @person = Person.find_by_crp_id(@crp)
        
      end
    end
  end
  
  desc "Populate database with House members"
  task :house => :environment do
    puts "Getting list of house members for 112th year of congress..."
    @doc = Nokogiri::XML(open(@@house_members))
    @house_members = @doc.xpath('//id')
    
    puts "Creating profiles..."
    @house_members.map { |member| 
      @id = member.inner_text
      
      if person_exists
        puts "skipping #{@id}"
      else
        begin
          @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@nyt_api_key}"))
        rescue Exception => e
          case e.message
            when /504 Gateway Timeout/
              puts "504 Gateway Timeout, retrying in 1..."
              sleep 1
              redo
          end
        end 
        if @person = Sunlight::Legislator.all_where(:bioguide_id => @id).first.blank?
          # load empty parameters because we cant find them using the bioguide_id
          @phone = ""
          @email = ""
          @crp_id = ""
          @fec_id = ""
          @votesmart_id = ""
        else
          @person = Sunlight::Legislator.all_where(:bioguide_id => @id).first
          @phone = @person.phone
          @email = @person.email
          @crp_id = @person.crp_id
          @fec_id = @person.fec_id
          @votesmart_id = @person.votesmart_id
        end
        
        ch = "H"
        make_person(ch)
        save_legislative_office
        
        puts "Added congressman #{@member_doc.xpath('//last_name').inner_text}" 
        sleep 1
      end
      }
      
      puts "All done!"

    end
    
  desc "Get list of current members of senate"
  task :senate => :environment do
  	puts "Getting list of current members of senate..."
  	@doc = Nokogiri::XML(open(@@senate_members))
  	@senate_members = @doc.xpath('//id')

  	puts "Creating new senator profiles..."
  	@senate_members.map { |member| 
  		@id = member.inner_text

  		if person_exists
        puts "skipping #{@id}"
      else
        begin
    		  @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@nyt_api_key}"))
    		rescue Exception => e
    		  case e.message
  		      when /504 Gateway Timeout/
  		        puts "504 Gateway Timeout, retrying in 1..."
  		        sleep 1
  		        redo
  		    end
  		  end
        if @person = Sunlight::Legislator.all_where(:bioguide_id => @id).first.blank?
          # load empty parameters because we cant find them using the bioguide_id
          @phone = ""
          @email = ""
          @crp_id = ""
          @fec_id = ""
          @votesmart_id = ""
        else
          @person = Sunlight::Legislator.all_where(:bioguide_id => @id).first
          @phone = @person.phone
          @email = @person.email
          @crp_id = @person.crp_id
          @fec_id = @person.fec_id
          @votesmart_id = @person.votesmart_id
        end
          
    		ch = "S"
    		make_person(ch)
    		save_legislative_office
        
        puts "Added senator #{@member_doc.xpath('//last_name').inner_text}"
        sleep 1
      end
      }

      puts "All done!"

   end
   
  desc "Do all of the committees & subcommittees (at once)"
  task :committees => [:main_committees, :subcommittees] do
    puts "All committees have been added to the database!"
  end
  
  desc "Add all committees from the sunlightlabs API"
  task :main_committees => :environment do
   
    puts "Populating committee arrays..."
    @senate_committees = Sunlight::Committee.all_for_chamber("Senate")
    sleep 1
    @house_committees = Sunlight::Committee.all_for_chamber("House")
    sleep 1
    @joint_committees = Sunlight::Committee.all_for_chamber("Joint")
    sleep 1
    
    puts "Saving senate committees..."
    @senate_committees.map do |sc|
      sleep 1
      puts "Saving #{sc.name}..."
      @committee = Committee.new(:name => sc.name, :code => sc.id, :chamber => sc.chamber)
      @committee.save
      
      sc.load_members
      sc.members.each do |member|
        puts "Mapping #{member.bioguide_id} to #{Committee.find_by_code(sc.id).name}!"
        
        if Person.find_by_nyt_id(member.bioguide_id).id.nil?          
          puts "Member with the id #{member.bioguide_id} does not exist, skipping!"
      	else
      	  @assignment = CommitteeAssignment.new(
      	      :person_id => Person.find_by_nyt_id(member.bioguide_id).id,
      	      :committee_id => Committee.find_by_code(sc.id).id
      	      )
      	  @assignment.save
      	end
    	end                                                                                 
    end
    
    puts "Saving house committees..."
    @house_committees.map do |hc|
      puts "Saving #{hc.name}..."
      @committee = Committee.new(:name => hc.name, :code => hc.id, :chamber => hc.chamber)
      @committee.save
      
      
      hc.load_members
      hc.members.each do |member|
        puts "Mapping #{member.bioguide_id} to #{Committee.find_by_code(hc.id).name}!"
        @assignment = CommitteeAssignment.new(
    	      :person_id => Person.find_by_nyt_id(member.bioguide_id).id,
    	      :committee_id => Committee.find_by_code(hc.id).id
    	      )
    	  @assignment.save
    	end
    end
    
    puts "Saving joint committees..."
    @joint_committees.map do |jc|
      puts "Saving #{jc.name}..."
      @committee = Committee.new(:name => jc.name, :code => jc.id, :chamber => jc.chamber)
      @committee.save      
      
      jc.load_members
      jc.members.each do |member|
        puts "Mapping #{member.bioguide_id} to #{Committee.find_by_code(jc.id).name}!"
        @assignment = CommitteeAssignment.new(
    	      :person_id => Person.find_by_nyt_id(member.bioguide_id).id,
    	      :committee_id => Committee.find_by_code(jc.id).id
    	      )
    	  @assignment.save
    	end
    end
    puts "All done!"
  end
  
  desc "Add subcommittees to committees"
  task :subcommittees => :environment do
    puts "Populating committee arrays..."
    @senate_committees = Sunlight::Committee.all_for_chamber("Senate")
    sleep 1
    @house_committees = Sunlight::Committee.all_for_chamber("House")
    sleep 1
    @joint_committees = Sunlight::Committee.all_for_chamber("Joint")
    sleep 1
    
    puts "Saving senate subcommittees..."
    @senate_committees.each do |committee|
      if committee.subcommittees.nil?
        next
      else
        committee.subcommittees.each do |sub|
          puts "Saving #{sub.name}..."
          @subcommittee = Subcommittee.new(:name => sub.name, :code => sub.id, :chamber => sub.chamber, :committee_id => Committee.find_by_code(committee.id).id)
          @subcommittee.save
          
          sub.load_members
          sub.members.each do |sm|
            puts "Mapping #{sm.bioguide_id} to #{sub.name}..."
            @subcommittee_assignment = SubcommitteeAssignment.new(
                :person_id => Person.find_by_nyt_id(sm.bioguide_id).id,
                :subcommittee_id => Subcommittee.find_by_code(sub.id).id
                )
            @subcommittee_assignment.save
          end
        end
      end
    end
    
    puts "Saving house subcommittees..."
    @house_committees.each do |committee|
      if committee.subcommittees.nil?
        next
      else
        committee.subcommittees.each do |sub|
          puts "Saving #{sub.name}..."
          @subcommittee = Subcommittee.new(:name => sub.name, :code => sub.id, :chamber => sub.chamber, :committee_id => Committee.find_by_code(committee.id).id)
          @subcommittee.save

          sub.load_members
          sub.members.each do |sm|
            puts "Mapping #{sm.bioguide_id} to #{sub.name}..."
            @subcommittee_assignment = SubcommitteeAssignment.new(
                :person_id => Person.find_by_nyt_id(sm.bioguide_id).id,
                :subcommittee_id => Subcommittee.find_by_code(sub.id).id
                )
            @subcommittee_assignment.save
          end
        end
      end
    end
      
    puts "Saving joint subcommittees..."
    @joint_committees.each do |committee|
      if committee.subcommittees.nil?
        next
      else
        committee.subcommittees.each do |sub|
          puts "Saving #{sub.name}..."
          @subcommittee = Subcommittee.new(:name => sub.name, :code => sub.id, :chamber => sub.chamber, :committee_id => Committee.find_by_code(committee.id).id)
          @subcommittee.save

          sub.load_members
          sub.members.each do |sm|
            puts "Mapping #{sm.bioguide_id} to #{sub.name}..."
            @subcommittee_assignment = SubcommitteeAssignment.new(
                :person_id => Person.find_by_nyt_id(sm.bioguide_id).id,
                :subcommittee_id => Subcommittee.find_by_code(sub.id).id
                )
            @subcommittee_assignment.save
          end
        end
      end
    end
    puts "Success!"
  end
  
  desc "Add all legislation attached to current members"
  task :legislation => :environment do
    make_join_with_prompt
    puts "Traversing legislation tree by congress member..."
    
    @congress_members.each do |member| 
      @id = member.inner_text
      @member = Person.find_by_nyt_id(@id)
      @member_chamber = @member.chamber
      puts "==||===================================================="
      puts "Updating legislation for legislator with the id #{@id}..."
      
      begin
        sleep 1
        @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}/bills/introduced.xml?api-key=#{@@nyt_api_key}"))
      rescue Exception => e
        case e.message
          when /403 Developer Over Rate/
            puts "over rate for the day!"
            exit
          when /504 Gateway Timeout/
            puts "504 Gateway Timeout, retrying in 1..."
            sleep 1
            redo
        end
      end
        
      sleep 2
      @bills = @member_doc.xpath('//results/bills/bill/number')
      number_bills = @bills.count 
      
      i = 1
      while i <= number_bills
        @bill_number = @member_doc.xpath("//results/bills/bill[#{i}]/number")
        @bill_number_stripped = @bill_number.inner_text.gsub(/[.]/, "").downcase
        
        begin
          sleep 1
          @bill_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}.xml?api-key=#{@@nyt_api_key_2}"))
        rescue Exception => e
          case e.message
            when /404 Not Found/
              sleep 1
              puts "Can't find this bill for the current year of congress, going back in time!"
              begin                
                @bill_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/111/bills/#{@bill_number_stripped}.xml?api-key=#{@@nyt_api_key}"))
              rescue Exception => e
                case e.message
                  when /504 Gateway Timeout/
                    puts "504 Gateway Timeout, retrying in 1..."
                    sleep 1
                    redo
                end
              end                
            when /504 Gateway Timeout/
              puts "504 Gateway Timeout, Retrying in 1..."
              sleep 1
              redo
            when /403 Developer Over Rate/
              puts "over rate for the day!"
              exit
          end
        end
        
        begin
          sleep 1
          @bill_cosponsors_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}/cosponsors.xml?api-key=#{@@nyt_api_key}"))
        rescue Exception => e
          case e.message
            when /504 Gateway Timeout/
              puts "504 Gateway Timeout, Retrying in 1..."
              sleep 1
              redo
            when /403 Developer Over Rate/
              puts "over rate for the day!"
              exit
          end
        end
        
        begin
          sleep 1
          @bill_subjects_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}/subjects.xml?api-key=#{@@nyt_api_key_2}"))
        rescue Exception => e
          case e.message
            when /504 Gateway Timeout/
              puts "504 Gateway Timeout, retrying in 1..."
              sleep 1
              redo
            when /403 Developer Over Rate/
              puts "over rate for the day!"
              exit
          end
        end
                      
        @bill_sponsor_id = @member_doc.xpath("//results/id").inner_text
        @bill_title = @member_doc.xpath("//results/bills/bill[#{i}]/title").inner_text
        @bill_introduced_date = @member_doc.xpath("//results/bills/bill[#{i}]/introduced_date").inner_text
        @bill_committees = @member_doc.xpath("//results/bills/bill[#{i}]/committees").inner_text
        @committees = @bill_committees.split("; ")
        
        @congress_year = @bill_doc.xpath("/result_set/results/congress").inner_text
        @bill_sponsor = @bill_doc.xpath("//results/sponsor").inner_text
        @bill_pdf_url = @bill_doc.xpath("//results/gpo_pdf_uri").inner_text
        @bill_latest_action = @bill_doc.xpath("//results/latest_major_action").inner_text
        @bill_latest_action_date = @bill_doc.xpath("//results/latest_major_action_date").inner_text
        
        @bill_subjects = @bill_subjects_doc.xpath("//results/subjects/subject/name")
        
        @bill_cosponsors = @bill_cosponsors_doc.xpath('//results/cosponsors[2]/cosponsor/cosponsor_id')
        @bill_democratic_cosponsors = @bill_cosponsors_doc.xpath('/result_set/results/cosponsors_by_party/party[@id = "D"]').inner_text
        @bill_republican_cosponsors = @bill_cosponsors_doc.xpath('/result_set/results/cosponsors_by_party/party[@id = "R"]').inner_text
        
        puts "Checking if #{@bill_number.inner_text} exists"        
        if bill_exists
          puts "Skipping bill number #{@bill_number.inner_text}, already exists!"
          # update_bill
          # update_bill_committees
          # update_legislation_issues
          # update_bill_cosponsors
          # update_related_bills
          
          sleep 2
          i += 1
        else
          puts "Creating new records for #{@bill_number.inner_text}..."
          puts "Making Bill..."
          make_bill
          puts "Saving committees for #{@bill_number.inner_text}..."
          save_bill_committees
          puts "Saving legislation issues for #{@bill_number.inner_text}..."
          save_legislation_issues
          puts "Saving cosponsors for #{@bill_number.inner_text}..."
          save_bill_cosponsors
          
          sleep 2
          i += 1
        end
      end
    end
  end
  
  def make_bill
    @legislation = Legislation.new(
        :bill_number => @bill_number.inner_text,
        :bill_title => @bill_title,
        :introduced_date => @bill_introduced_date,
        :latest_major_action_date => @bill_latest_action_date,
        :latest_major_action => @bill_latest_action, 
        :bill_sponsor => @bill_sponsor,
        :bill_sponsor_id => @bill_sponsor_id,
        :bill_pdf => @bill_pdf_url,
        :congress_year => @congress_year,
        :democratic_cosponsors => @bill_democratic_cosponsors,
        :republican_cosponsors => @bill_republican_cosponsors
        )    
    if @legislation.save
      puts "#{@bill_number.inner_text} saved!"
    end
  end
  
  def save_bill_committees
    @committees.map do |committee| 
      if Committee.where("name like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "")}").empty?
        puts "#{committee} not on file, adding it to the database!"
        @committee = Committee.new(:name => committee, :chamber => "")
        @committee.save
        @committee_legislation = CommitteeLegislation.new(
            :legislation_id => Legislation.find_by_bill_number(@bill_number.inner_text).id,
            :committee_id => Committee.where("name like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "").gsub(/\bJoint\b/, "")}").first.id,
            :year => "112"
            )
      else
        @committee = Committee.where("name like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "")}").first
        @committee_legislation = CommitteeLegislation.new(
            :legislation_id => Legislation.find_by_bill_number(@bill_number.inner_text).id,
            :committee_id => Committee.where("name like ? AND chamber like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "").gsub(/\bJoint\b/, "")}", "#{@committee.chamber}").first.id,
            :year => "112"
            )
      end
      if @committee_legislation.save
        puts "#{committee} mapped to #{@bill_number.inner_text}"
      end
    end
  end
  
  def save_legislation_issues
    if @bill_subjects.count > 0
      @bill_subjects.map do |subject|
        puts "Mapping #{subject.inner_text} to #{@bill_number.inner_text}..."
        @issue = Issue.find_or_create_by_name(subject.inner_text)
        @issue_legislation = LegislationIssue.new(
           :legislation_id => Legislation.find_by_bill_number(@bill_number.inner_text).id,
           :issue_id => Issue.find_by_name(subject.inner_text).id,
           :year => @congress_year
         )
        if @issue_legislation.save
          puts "#{subject.inner_text} mapped to legislation: #{@bill_number.inner_text}"
        end
      end
    end
  end
  
  def save_bill_cosponsors
    if @bill_cosponsors.count > 0
      @bill_cosponsors.each do |cosponsor_id|
        @legislation_cosponsor = LegislationCosponsor.new(
            :person_id => Person.find_by_nyt_id(cosponsor_id.inner_text).id,
            :legislation_id => Legislation.find_by_bill_number(@bill_number.inner_text).id
            )
        if @legislation_cosponsor.save
          puts "#{cosponsor_id.inner_text} mapped to #{Legislation.find_by_bill_number(@bill_number.inner_text).bill_number}"
        end
      end
    else
      puts "No cosponsors for this bill!"
    end
    puts "#{Legislation.find_by_bill_number(@bill_number.inner_text).bill_number} saved!!!!!!!!!!!!!!!!"
  end
  
  def save_committee_assignment
    @committee_assignment = CommitteeAssignment.new(
        :person_id => Person.find_by_nyt_id(@id).id,
        :committee_id => Committee.find_by_code(@code).id,
        :year => "112" 
        )
    @committee_assignment.save
  end
  
  def make_person(ch)
    @chamber = ch
    @person = Person.new(
        :first_name => @member_doc.xpath('//first_name').inner_text, 
        :middle_name => @member_doc.xpath('//middle_name').inner_text,
        :last_name => @member_doc.xpath('//last_name').inner_text,
        :date_of_birth => @member_doc.xpath('//date_of_birth').inner_text,
        :gender => @member_doc.xpath('//gender').inner_text,
        :contact_web_page_url => @member_doc.xpath('//url').inner_text,
        :times_topics_url => @member_doc.xpath('//times_topics_url').inner_text,
        :govtrack_id => @member_doc.xpath('//govtrack_id').inner_text,
        :cspan_id => @member_doc.xpath('//cspan_id').inner_text,
        :icpsr_id => @member_doc.xpath('//icpsr_id').inner_text,
        :twitter_id => @member_doc.xpath('//twitter_id').inner_text,
        :youtube_id => @member_doc.xpath('//youtube_id').inner_text,
        :current_party => @member_doc.xpath('//current_party').inner_text,
        :chamber => @chamber, 
        :contact_phone => @phone,
        :contact_email => @email,
        :nyt_id => @id,
        :fec_id => @fec_id,
        :crp_id => @crp_id,
        :votesmart_id => @votesmart_id    
        )
    @person.save
  end
  
  def save_legislative_office
    roles_count = @member_doc.xpath('//result_set/results/member/roles/role').count
    
    i = 1
    while i <= roles_count
      @congress_year = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/congress").inner_text
      @chamber = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/chamber").inner_text
      @state = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/state").inner_text
      @district = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/district").inner_text
      @party = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/party").inner_text
      @seniority = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/seniority").inner_text
      @start_date = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/start_date").inner_text
      @end_date = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/end_date").inner_text
      @bills_sponsored = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/bills_sponsored").inner_text
      @bills_cosponsored = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/bills_cosponsored").inner_text
      @missed_votes_pct = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/missed_votes_pct").inner_text
      @votes_with_party_pct = @member_doc.xpath("//result_set/results/member/roles/role[#{i}]/votes_with_party_pct").inner_text
      @id = @member_doc.xpath("/result_set/results/member/id").inner_text
      
      @office = LegislativeOffice.new(
        :person_id => Person.find_by_nyt_id(@id).id,
        :congress_year => @congress_year,
        :chamber => @chamber,
        :state => @state,
        :district => @district,
        :party => @party, 
        :seniority => @seniority,
        :start_date => @start_date,
        :end_date => @end_date,
        :bills_sponsored => @bills_sponsored,
        :bills_cosponsored => @bills_cosponsored,
        :missed_votes_pct => @missed_votes_pct,
        :votes_with_party_pct => @votes_with_party_pct 
        )
      if @office.save
        puts "Role ##{i} saved for #{@id}!"
        i += 1
      end
    end  
  end
  
  def make_join_with_prompt
    make_join

    puts "Splitting up congress members into three parts..."
    @congress_part_1 = @congress_members[1..184]
    @congress_part_2 = @congress_members[185..369]
    @congress_part_3 = @congress_members[369..600]

    choose do |menu|
      menu.prompt = "Please choose from one of the following, you 
      can only run one per day or it will fail part of the way 
      through. DO NOT RUN MORE THAN ONE ITEM PER DAY!"
      menu.choice(:congress_part_one) do
        @congress_members = @congress_part_1
      end
      menu.choice(:congress_part_two) do
        @congress_members = @congress_part_2
      end
      menu.choice(:congress_part_three) do
        @congress_members = @congress_part_3
      end
    end
  end
  
  def make_join
    puts "Making list of senators..."
    @senate_doc = Nokogiri::XML(open(@@senate_members))
  	@senate_members = @senate_doc.xpath('//id')
  	sleep 1

    puts "Making list of congresspeople..."
    @house_doc = Nokogiri::XML(open(@@house_members))
    @house_members = @house_doc.xpath('//id')
    sleep 1

    puts "Joining list..."
    @congress_members = @house_members + @senate_members
  end
  
  def issue_exists
    if Issue.find_by_name("#{issue}").nil?
      false
    else
      true
    end
  end
  
  def bill_exists
    if Legislation.find_by_bill_number("#{@bill_number.inner_text}").nil?
      false
    else
      true
    end
  end
  
  def committee_exists
    if Committee.find_by_name("#{@name}").nil?
      false
    else
      true
    end
  end
  
  def find_or_create_committee
    if Committee.where("name like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "")}").nil?
      @committee = Committee.new(:name => committee)
      @committee.save
    else
      Committee.where("name like ?", "%#{committee.gsub(/\bHouse\b/, "").gsub(/\bSenate\b/, "")}")
    end
  end
  
  def committee_assignment_exists
    if CommitteeAssignment.where
      false
    else
      true
    end
  end

  def person_exists
    if Person.find_by_nyt_id("#{@id}").nil?
      false
    else
      true
    end
  end
  
end