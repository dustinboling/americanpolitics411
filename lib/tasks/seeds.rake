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

  ###
  # NEW STUFF
  #
  #<Sunlight::Legislator:0x007f8ea7176e60 @website="http://www.kohl.senate.gov/", @fax="202-224-9787", @govtrack_id="300061", @firstname="Herbert", @middlename="H.", @lastname="Kohl", @congress_office="330 Hart Senate Office Building", @phone="202-224-5653", @webform="http://www.kohl.senate.gov/contact.cfm", @youtube_url="http://www.youtube.com/SenatorKohl", @nickname="Herb", @gender="M", @district="Senior Seat", @title="Sen", @congresspedia_url="http://www.opencongress.org/wiki/Herbert_Kohl", @in_office=true, @senate_class="I", @name_suffix="", @twitter_id="", @birthdate=1935-02-07 00:00:00 -0800, @bioguide_id="K000305", @fec_id="S6WI00061", @state="WI", @crp_id="N00004309", @facebook_id="herbkohl", @party="D", @email="", @votesmart_id="53362">
  desc "Populate database with addresses of congress members"
  task :addresses => :environment do |t, args|
    puts "Getting list of congress members..."
    people = Person.where(:is_congress_member => true)
    people.each do |p|
      person_id = p.id
      person = Sunlight::Legislator.all_where(:bioguide_id => p.bioguide_id)
      unless person.nil? || person.first.nil?
        person = person.first
        a = Address.new
        a.person_id = person_id
        a.title = "Congressional Office"
        a.street_address = person.congress_office
        a.city = "Washington" 
        a.state = "D.C."
        a.phone = person.phone
        a.fax = person.fax
        a.email = person.email
        a.web_url = person.website
        if a.save
          puts "Addded 1 address for #{p.bioguide_id}..."
        else
          puts "Error on: #{p.bioguide_id}..."
        end
      end
    end
    puts "All done."
  end

  desc "Populate database with legislation"
  task :legislation, [:session] => :environment do |t, args|
    if args.session.nil?
      abort("You must pass a session number:\n  rake seed:legislation [session]\n\nNOTE: if you are using zsh then escape brackets like so: rake seed:legislation\\[session\\]")
    end
    puts "Adding legislation for session ##{args.session}..."
    client = Congress::Client.new
    legislation = client.bills(:session => args.session)

    puts "Total number of bills: #{legislation['count']}"
    batches = (legislation['count'].to_i / 50.0).ceil

    page = 1
    batches.times do
      legislation = client.bills(:session => args.session, :per_page => 50, :page => page)
      bills = legislation['bills']
      bills.each do |b|
        introduced_year = b.introduced_at.to_time.year
        @bill = b
        if b.chamber == "senate"
          @chamber = "S"
        elsif b.chamber == "house"
          @chamber = "H"
        end

        # add legislation
        puts "==||=============================="
        puts "Adding legislation: #{b.number}..."
        if b.sponsor.nil?
          @first_name = ""
          @last_name = ""
        else
          @first_name = b.sponsor.first_name
          @last_name = b.sponsor.last_name
        end
        if b.last_version.nil?
          @pdf = nil
          @last_major_action = nil
        else
          @pdf = b.last_version.urls.pdf
          begin
            @last_major_action = b.last_action.text
          rescue Exception => e
            @last_major_action = nil
            puts "This happened: #{e}, continuing..."
          end
        end
        l = Legislation.create(
          :rtc_id => b.bill_id,
          :bill_type => b.bill_type,
          :bill_number => b.number, 
          :session => b.session,
          :introduced_year => introduced_year,
          :introduced_date => b.introduced_at,
          :chamber => @chamber,
          :short_title => b.short_title,
          :bill_title => b.official_title,
          :popular_title => b.popular_title,
          :summary => b.summary,
          :bill_sponsor => "#{@first_name} #{@last_name}",
          :bill_sponsor_id => b.sponsor_id,
          :bill_pdf => @pdf,
          :latest_major_action => @last_major_action,
          :latest_major_action_date => b.last_action_at
        )

        # add legislation issues
        puts "Adding issues... for #{b.number}"
        legislation_issues = @bill.keywords
        legislation_issues.each do |li|
          if Issue.find_by_name(li)
            puts "assigning #{li} to #{Legislation.find_by_rtc_id(@bill.bill_id).bill_number}"
            l_issue = LegislationIssue.create(
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
              :issue_id => Issue.find_by_name(li).id
            )
          else 
            puts "adding issue: #{li}."
            issue = Issue.create(
              :name => li
            )
            l_issue = LegislationIssue.create(
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
              :issue_id => issue.id
            )
          end
        end

        # add cosponsors
        puts "Adding cosponsors..."
        cosponsors = @bill.cosponsors
        cosponsors.each do |c|
          unless Person.find_by_bioguide_id(c.bioguide_id).nil?
            l = LegislationCosponsor.create(
              :person_id => Person.find_by_bioguide_id(c.bioguide_id).id,
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id
            )
          end
        end

        # add committees
        puts "Adding committees..."
        committees = @bill.committees
        committees.each do |c|
          code = c[1]['committee']['committee_id']
          name = c[1]['committee']['name']
          chamber = c[1]['committee']['chamber']
          if Committee.find_by_code(code)
            cl = CommitteeLegislation.create(
              :committee_id => Committee.find_by_code(code).id,
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id
            )
          else 
            co = Committee.create(
              :code => code,
              :name => name,
              :chamber => chamber
            )
            cl = CommitteeLegislation.create(
              :committee_id => co.id,
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id
            )
          end
        end

        # add actions
        puts "Adding actions..."
        actions = @bill.actions
        actions.each do |a|
          action = Action.create(
            :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
            :acted_at => a.acted_at,
            :text => a.text
          )
        end

        # add votes
        puts "Adding votes..."
        passage_votes = @bill.passage_votes
        passage_votes.each do |p|
          legislation_id = Legislation.find_by_rtc_id(@bill.bill_id).id
          pv = PassageVote.create(
            :legislation_id => legislation_id, 
            :result => p.result,
            :voted_at => p.voted_at, 
            :passage_type => p.passage_type, 
            :text => p.text,
            :how => p.how,
            :roll_id => p.roll_id,
            :chamber => p.chamber
          ) 
        end
      end
      page = page + 1
    end
    Update.create(:task => "legislation")
  end

  desc "Add bill votes to people."
  task :votes, [:session] => :environment do |t, args|
    puts "Connecting client..."
    client = Congress::Client.new

    page = 1
    total_votes = client.votes(:session => args.session, :per_page => 50)
    puts "Total number of votes: #{total_votes['count']}"
    batches = (total_votes['count'].to_i / 50.0).ceil
    batches.times do
      votes_ary = client.votes(:session => args.session, :per_page => 50, :page => page)
      votes = votes_ary['votes']
      puts "==|Batch #{page}|==========================="
      votes.each do |v|
        puts "Adding votes for #{v.bill_id}..."
        rtc_id = v.bill_id
        if v.voted_at
          @voted_at = v.voted_at
        end
        @how = v.how
        @result = v.result
        if Legislation.find_by_rtc_id(rtc_id)
          legislation = Legislation.find_by_rtc_id(rtc_id)
          legislation_id = legislation.id
          voters = v.voters
          voters.each do |voter|
            bioguide_id = voter[1].voter.bioguide_id
            vote = voter[1].vote
            if Person.find_by_bioguide_id(bioguide_id)
              person_id = Person.find_by_bioguide_id(bioguide_id).id
              PersonVote.create(
                :legislation_id => legislation_id,
                :person_id => person_id,
                :vote => vote,
                :voted_at => @voted_at,
                :how => @how,
                :result => @result
              )
            else
              # do nothing
            end
          end
        else
          # do nothing
        end
      end
      page = page + 1
    end
    Update.create(:task => "votes")
  end

  desc "Add photo urls"
  task :photos => :environment do
    people = Person.all
    people.each do |p|
      puts "adding photo for #{p.first_name} #{p.last_name}"
      base_url = "http://www.govtrack.us/data/photos/"
      photo_url = base_url + p.govtrack_id + "-200px.jpeg"
      p.update_attributes(
        :photo_url => photo_url
      )
    end
  end

  desc "Populate database with current congress members"
  task :congress => :environment do
    puts "Adding current house members to the database..."
    representatives = Sunlight::Legislator.all_where(:in_office => 1, :title => "Rep")
    representatives.each do |r|
      create_person(r, "H")
      puts "#{r.bioguide_id}"
    end

    puts "Adding current senate members to the database..."
    senators = Sunlight::Legislator.all_where(:in_office => 1, :title => "Sen")
    senators.each do |s|
      create_person(s, "S")
      puts "#{s.bioguide_id}"
    end
    puts "All done!"
  end

  def create_person(person, chamber)
    # set up youtube id from url
    youtube_url = person.youtube_url
    youtube_url_array = youtube_url.split('/')
    youtube_id = youtube_url_array[-1]
    p = Person.new
    p.update_attributes({
      :is_congress_member => true,
      :chamber => chamber,
      :in_office => person.in_office,
      :state_represented => person.state,
      :district => person.district,
      :crp_id => person.crp_id,
      :current_party => person.party,
      :contact_email => person.email,
      :votesmart_id => person.votesmart_id,
      :contact_web_page_url => person.website,
      :contact_fax => person.fax,
      :govtrack_id => person.govtrack_id,
      :first_name => person.firstname,
      :middle_name => person.middlename,
      :last_name => person.lastname,
      :contact_street_address => person.congress_office,
      :contact_phone => person.phone,
      :webform => person.webform,
      :youtube_id => youtube_id,
      :nickname => person.nickname,
      :bioguide_id => person.bioguide_id,
      :fec_id => person.fec_id,
      :gender => person.gender,
      :senate_class => person.senate_class,
      :suffix => person.name_suffix,
      :twitter_id => person.twitter_id,
      :date_of_birth => person.birthdate,
      :congresspedia_url => person.congresspedia_url
    })
  end

  ###
  # OK
  #
  desc "Add states to congress members"
  task :states => :environment do 
    people = Person.all
    people.each do |p|
      bioguide_id = p.nyt_id
      ph = Sunlight::Legislator.all_where(:bioguide_id => bioguide_id).first
      if ph.nil?
        puts "Could not find data for #{bioguide_id}!"
      else
        puts "Updating #{ph.bioguide_id}"
        p.state_represented = ph.state
        p.save
      end
    end
  end

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
      else
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
    CSV.foreach(csv, "r:ISO-8859-15:UTF-8") do |row|
      @crp = row[2].gsub("|", "")
    end

    @crp_ids.each do |crp|
      if crp.blank?
        puts "Entry blank, skipping!"
      else
        p = Person.find_by_crp_id(@crp)
        asset = Asset.create()
      end
    end
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

        if Person.find_by_bioguide_id(member.bioguide_id).id.nil?          
          puts "Member with the id #{member.bioguide_id} does not exist, skipping!"
        else
          @assignment = CommitteeAssignment.new(
            :person_id => Person.find_by_bioguide_id(member.bioguide_id).id,
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
          :person_id => Person.find_by_bioguide_id(member.bioguide_id).id,
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
          :person_id => Person.find_by_bioguide_id(member.bioguide_id).id,
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
          if Subcommittee.find_by_name(sub.name)
            @subcommittee = Subcommittee.find_by_name(sub.name)
          else
            @subcommittee = Subcommittee.new(:name => sub.name, :code => sub.id, :chamber => sub.chamber, :committee_id => Committee.find_by_code(committee.id).id)
            @subcommittee.save
          end

          sub.load_members
          sub.members.each do |sm|
            puts "Mapping #{sm.bioguide_id} to #{sub.name}..."
            @subcommittee_assignment = SubcommitteeAssignment.new(
              :person_id => Person.find_by_bioguide_id(sm.bioguide_id).id,
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
              :person_id => Person.find_by_bioguide_id(sm.bioguide_id).id,
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
              :person_id => Person.find_by_bioguide_id(sm.bioguide_id).id,
              :subcommittee_id => Subcommittee.find_by_code(sub.id).id
            )
            @subcommittee_assignment.save
          end
        end
      end
    end
    puts "Success!"
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
          :person_id => Person.find_by_bioguide_id(cosponsor_id.inner_text).id,
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
      :person_id => Person.find_by_bioguide_id(@id).id,
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
        :person_id => Person.find_by_bioguide_id(@id).id,
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
    @congress_part_1 = @congress_members[1..100]
    @congress_part_2 = @congress_members[101..200]
    @congress_part_3 = @congress_members[201..300]
    @congress_part_4 = @congress_members[301..400]
    @congress_part_5 = @congress_members[401..500]
    @congress_part_6 = @congress_members[501..600]
    last_line = `tail -n 1 /users/alan/sites/politics411/last_part.txt`

    choose do |menu|
      menu.prompt = "Please choose from one of the following, you\n 
      can only run one per day or it will fail part of the way\n 
      through. DO NOT RUN MORE THAN ONE ITEM PER DAY!\n
      The last batch you ran was: #{last_line}"
      menu.choice(:congress_part_one) do
        @congress_members = @congress_part_1
        write_last_run("congress_part_one")
      end
      menu.choice(:congress_part_two) do
        @congress_members = @congress_part_2
        write_last_run("congress_part_two")
      end
      menu.choice(:congress_part_three) do
        @congress_members = @congress_part_3
        write_last_run("congress_part_three")
      end
      menu.choice(:congress_part_four) do
        @congress_members = @congress_part_4
        write_last_run("congress_part_four")
      end
      menu.choice(:congress_part_five) do
        @congress_members = @congress_part_5
        write_last_run("congress_part_five")
      end
      menu.choice(:congress_part_six) do
        @congress_members = @congress_part_6
        write_last_run("congress_part_six")
      end
    end
  end

  def make_thomas_url(legislation)
    # input from collection
    year = legislation.congress_year
    full_bill_number = legislation.bill_number

    # perform text manipulation
    type = full_bill_number.gsub(/[0-9.]+/, '')
    number = full_bill_number.gsub(/\D+/, '')
    loc_number = to_loc(number)
    loc_query_number = type + loc_number

    # construct the url
    base_url = "http://thomas.loc.gov/cgi-bin/bdquery/z?d"
    @query = base_url + year + ":" + loc_query_number + ":@@@D&summ2=m&"
  end

  def write_last_run(part)
    File.open('/users/alan/sites/politics411/last_part.txt', 'a') { |f| f.write("#{part}\n") }
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
    if Person.find_by_bioguide_id("#{@id}").nil?
      false
    else
      true
    end
  end

  def to_loc(number)
    case number.length
    when 1
      pre = "0000"
      number = pre + number
    when 2
      pre = "000"
      number = pre + number
    when 3
      pre = "00"
      number = pre + number
    when 4
      pre = "0"
      number = pre + number
    when 5
      number
    end
  end
end
