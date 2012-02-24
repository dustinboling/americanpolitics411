namespace :seed do  
  
  require 'open-uri'
  
  @@api_key = 'b16efb69e13af05498fe536551a7bc67:15:65673083'
  @@house_members = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/house/members.xml?api-key=#{@@api_key}"
  @@senate_members = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/senate/members?api-key=#{@@api_key}"
  
  desc "Grab top level list"
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
        @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@api_key}"))
        house = "h"
        make_person(house)
        
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
    		@member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@api_key}"))
    		senate = "s"
    		make_person(senate)
        
        puts "Added senator #{@member_doc.xpath('//last_name').inner_text}" 
        sleep 1
      end
      }

      puts "All done!"

   end
  
  desc "Add all recent committees"
  task :committees => :environment do
    puts "Making list of senators..."
    @senate_doc = Nokogiri::XML(open(@@senate_members))
  	@senate_members = @senate_doc.xpath('//id')
  	
    puts "Making list of congresspeople..."
    @house_doc = Nokogiri::XML(open(@@house_members))
    @house_members = @house_doc.xpath('//id')
    
    puts "Joining list..."
    @congress_members = @house_members + @senate_members
    
    puts "Beginning datastore..."
    @congress_members.map { |member|
      @id = member.inner_text
      
      if person_exists
        puts "Saving committees for #{Person.find_by_nyt_id(@id).name}..."
        @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@api_key}")) rescue redo
        @committees =  @member_doc.xpath('//results/member/roles/role[1]/committees/committee/name')
        number_committees = @committees.count
        
        i = 1        
        while i <= number_committees do
          @name = @member_doc.xpath("//results/member/roles/role[1]/committees/committee[#{i}]/name").inner_text
          @code = @member_doc.xpath("//results/member/roles/role[1]/committees/committee[#{i}]/code").inner_text
          @nyt_uri = @member_doc.xpath("//results/member/roles/role[1]/committees/committee[#{i}]/api_uri").inner_text
          
          if committee_exists
            puts "Committee with the name #{@name} already exists, skipping!"
          else
            @committee = Committee.new(:name => @name, :code => @code, :nyt_uri => @nyt_uri)
            @committee.save
            save_committee_assignment
          end
                 
          sleep 2
          i += 1 
        end
      end
    }
  end
  
  desc "Add all legislation attached to current members"
  task :legislation => :environment do
    make_join
    puts "Traversing legislation tree by congress member..."
    @congress_members.map { |member| 
      @id = member.inner_text
      @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}/bills/introduced.xml?api-key=#{@@api_key}")) rescue redo
      @bills = @member_doc.xpath('//results/bills/bill/number')
      number_bills = @bills.count
      
      i = 1
      while i <= number_bills
        @bill_number = @member_doc.xpath("//results/bills/bill[#{i}]/number")
        @bill_number_stripped = @bill_number.inner_text.gsub(/[.]/, "").downcase
        @bill_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}.xml?api-key=#{@@api_key}")) rescue redo
        sleep 1
        @bill_cosponsors_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}/cosponsors.xml?api-key=#{@@api_key}")) rescue redo
        sleep 1
        @bill_subjects_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}/subjects.xml?api-key=#{@@api_key}")) rescue redo
        sleep 1
        @bill_related_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/bills/#{@bill_number_stripped}/related.xml?api-key=#{@@api_key}")) rescue redo
        sleep 1
        
        @congress_year = "112"
        @bill_title = @member_doc.xpath("//results/bills/bill[#{i}]/title").inner_text
        @bill_introduced_date = @member_doc.xpath("//results/bills/bill[#{i}]/introduced_date").inner_text
        @bill_committees = @member_doc.xpath("//results/bills/bill[#{i}]/committees").inner_text
        @committees = @bill_committees.split("; ")
        @bill_sponsor_id = @member_doc.xpath("//results/id").inner_text
        
        @bill_sponsor = @bill_doc.xpath("//results/sponsor").inner_text
        @bill_pdf_url = @bill_doc.xpath("//results/gpo_pdf_uri").inner_text
        @bill_latest_action = @bill_doc.xpath("//results/latest_major_action").inner_text
        @bill_latest_action_date = @bill_doc.xpath("//results/latest_major_action_date").inner_text
        
        @bill_subjects = @bill_subjects_doc.xpath("//results/subjects/subject/name")
        
                
        if bill_exists
          puts "Skipping bill number #{@bill_number.innertext}, already exists!"
        else
          make_bill
          # save_bill_committees : need to figure out how to separate out senate/house committees
          save_legislation_issues
          save_bill_cosponsors
        end
      end
      
    }
    
  end
  
  def save_bill_cosponsors
    
  end
  
  def save_legislation_issues
    @bill_subjects.map { |issue|
      puts "Checking if issue exists..."
      if issue_exists(issue)
        puts "Issue with the name #{issue.inner_text} already exists, skipping!"
      else
        puts "Making new issue with the name #{issue.inner_text}..."
        @issue = Issue.new(
            :name => issue.inner_text)
        # @issue.save
      end
      
      puts "Mapping issue #{issue.inner_text} to legislation: #{@bill_number.inner_text}..."
      @issue_legislation = LegislationIssue.new(
          :legislation_id => Legislation.find_by_bill_number(@bill_number).id,
          :issue_id => Issue.find_by_name(issue.inner_text).id,
          :year => @congress_year
          )
      # @issue_legislation.save
      }
  end
  
  def save_bill_comittees
    @committees.map { |committee| 
      @committee_legislation = CommitteeLegislation.new(
          :legislation_id => Legislation.find_by_bill_number(@bill_number).id,
          :committee_id => Committee.find_by_name(find_or_create_committee).id, 
          :year => @congress_year
          )
        }
  end
  
  def save_committee_assignment
    @committee_assignment = CommitteeAssignment.new(
        :person_id => Person.find_by_nyt_id(@id).id,
        :committee_id => Committee.find_by_code(@code).id,
        :year => "112" 
        )
    @committee_assignment.save
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
        :congress_year => @congress_year
        )
    @legislation.save
  end
  
  def make_person(chamber)
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
        :chamber => chamber.upcase, 
        :nyt_id => @id
        )
    @person.save
  end
  
  def make_join
    puts "Making list of senators..."
    @senate_doc = Nokogiri::XML(open(@@senate_members))
  	@senate_members = @senate_doc.xpath('//id')

    puts "Making list of congresspeople..."
    @house_doc = Nokogiri::XML(open(@@house_members))
    @house_members = @house_doc.xpath('//id')

    puts "Joining list..."
    @congress_members = @house_members + @senate_members
  end
  
  def issue_exists(issue)
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