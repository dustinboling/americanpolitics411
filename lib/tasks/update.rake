namespace :update do

  desc "Add new legislators since last update"
  task :people => :environment do
    puts "updating representatives..."
    @count = 0
    representatives = Sunlight::Legislator.all_where(:in_office => 1, :title => "Rep")
    representatives.each do |r|
      create_or_skip_person(r, "H")
    end

    puts "updating senators..."
    senators = Sunlight::Legislator.all_where(:in_office => 1, :title => "Sen")
    senators.each do |s|
      create_or_skip_person(s, "S")
    end

    u = Update.new(:task => "people", :count => @count)
    u.save

    puts "#{@count} records added..."
    puts "all done."
  end

  desc "Update legislation since last update."
  task :legislation => :environment do
    client = Congress::Client.new
    last_update = Update.where(:task => "legislation").last
    @last_updated_at = last_update.utc_timestamp.strftime("%Y-%m-%dT%H:%M:%SZ")
    legislation = client.bills(:introduced_at__gte => @last_updated_at)

    puts "Total number of bills: #{legislation['count']}"
    batches = (legislation['count'].to_i / 50.0).ceil

    page = 1
    batches.times do
      legislation = client.bills(
        :introduced_at__gte => @last_updated_at, 
        :per_page => 50, 
        :page => page
      )
      bills = legislation['bills']
      @bill_count = 1
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
        unless b.bill_id == nil || Legislation.find_by_rtc_id(b.bill_id)
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
          puts "added #{l.rtc_id}!"
        end
      
        # add legislation issues
        puts "Adding issues... for #{b.number}"
        legislation_issues = @bill.keywords
        unless Legislation.find_by_rtc_id(@bill.bill_id).nil? || legislation_issues.nil?
          legislation_id = Legislation.find_by_rtc_id(@bill.bill_id).id

          legislation_issues.each do |legislation_issue|
            if Issue.find_by_name(legislation_issue) && LegislationIssue.does_not_exist(legislation_id, Issue.find_by_name(legislation_issue).id)
              puts "assigning #{legislation_issue} to #{Legislation.find_by_rtc_id(@bill.bill_id).bill_number}"
              l_issue = LegislationIssue.create(
                :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
                :issue_id => Issue.find_by_name(legislation_issue).id
              )
            else 
              puts "adding issue: #{legislation_issue}."
              issue = Issue.create(
                :name => legislation_issue
              )
              l_issue = LegislationIssue.create(
                :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
                :issue_id => issue.id
              )
            end
          end
        end

        # add cosponsors
        puts "Adding cosponsors..."
        cosponsors = @bill.cosponsors
        cosponsors.each do |c|
          unless Person.find_by_bioguide_id(c.bioguide_id).nil? || Legislation.find_by_rtc_id(@bill.bill_id).nil?
            person_id = Person.find_by_bioguide_id(c.bioguide_id).id
            legislation_id = Legislation.find_by_rtc_id(@bill.bill_id).id

            unless LegislationCosponsor.exists?(person_id, legislation_id)
              l = LegislationCosponsor.create(
                :person_id => person_id,
                :legislation_id => legislation_id
              )
              puts "Added #{c.bioguide_id} to #{@bill.bill_id}!"
            end
          end
        end

        # add committees
        puts "Adding committees..."
        committees = @bill.committees
        unless committees.nil?
          committees.each do |c|
            code = c[1]['committee']['committee_id']
            name = c[1]['committee']['name']
            chamber = c[1]['committee']['chamber']
            
            unless Committee.find_by_code(code).nil? || Legislation.find_by_rtc_id(@bill.bill_id).nil?
              committee_id = Committee.find_by_code(code).id
              legislation_id = Legislation.find_by_rtc_id(@bill.bill_id).id

              if Committee.find_by_code(code) && CommitteeLegislation.does_not_exist(committee_id, legislation_id)
                cl = CommitteeLegislation.create(
                  :committee_id => committee_id,
                  :legislation_id => legislation_id
                )
              elsif Committee.find_by_code(code) && CommitteeLegislation.exists?(committee_id, legislation_id)
                # do nothing
              else 
                co = Committee.create(
                  :code => code,
                  :name => name,
                  :chamber => chamber
                )
                cl = CommitteeLegislation.create(
                  :committee_id => co.id,
                  :legislation_id => legislation_id
                )
              end
            end
          end
        end

        # add actions
        puts "Adding actions..."
        actions = @bill.actions
        actions.each do |a|
          unless Legislation.find_by_rtc_id(@bill.bill_id).nil?
            legislation_id = Legislation.find_by_rtc_id(@bill.bill_id).id
            if Action.does_not_exist(legislation_id, a.acted_at, a.text)
              action = Action.create(
                :legislation_id => legislation_id,
                :acted_at => a.acted_at,
                :text => a.text
              )
              puts "Added action ##{action.id}!"
            end
          end
        end
        @bill_count = @bill_count + 1
      end
      page = page + 1
    end
    Update.create(:task => "legislation", :count => @bill_count)
    puts "Added #{@bill_count} bills."
  end

  desc "Update votes"
  task :votes => :environment do
    puts "Connecting client..."
    client = Congress::Client.new
    last_update = Update.where(:task => "votes").last
    @last_updated_at = last_update.utc_timestamp.strftime("%Y-%m-%dT%H:%M:%SZ")

    page = 1
    @vote_count = 1
    total_votes = client.votes(:voted_at__gte => @last_updated_at, :per_page => 50)
    puts "Total number of votes: #{total_votes['count']}"
    batches = (total_votes['count'].to_i / 50.0).ceil
    batches.times do
      votes_ary = client.votes(:voted_at__gte => @last_updated_at, :per_page => 50, :page => page)
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
            if Person.find_by_bioguide_id(bioguide_id) && PersonVote.does_not_exist(legislation_id, person_id, @voted_at)
              person_id = Person.find_by_bioguide_id(bioguide_id).id
              PersonVote.create(
                :legislation_id => legislation_id,
                :person_id => person_id,
                :vote => vote,
                :voted_at => @voted_at,
                :how => @how,
                :result => @result
              )
              @vote_count = @vote_count + 1
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
    Update.create(:task => "votes", :count => @vote_count)
    puts "Added #{@vote_count} votes."
  end

  def create_or_skip_person(person, chamber)
    unless Person.find_by_bioguide_id(person.bioguide_id)
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
      @count = @count + 1
    end
  end
end
