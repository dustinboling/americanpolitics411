namespace :update do

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
        unless Legislation.find_by_rtc_id(@bill.bill_id).nil? || Issue.find_by_name(li).nil?
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
        end

        # add cosponsors
        puts "Adding cosponsors..."
        cosponsors = @bill.cosponsors
        cosponsors.each do |c|
          unless Person.find_by_bioguide_id(c.bioguide_id).nil? || Legislation.find_by_rtc_id(@bill.bill_id).nil?
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
          unless Committee.find_by_code(code).nil? || Legislation.find_by_rtc_id(@bill.bill_id).nil?
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
        end

        # add actions
        puts "Adding actions..."
        actions = @bill.actions
        actions.each do |a|
          unless Legislation.find_by_rtc_id(@bill.bill_id).nil?
            action = Action.create(
              :legislation_id => Legislation.find_by_rtc_id(@bill.bill_id).id,
              :acted_at => a.acted_at,
              :text => a.text
            )
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
    total_votes = client.votes(:voted_at__gte => @last_updated_at, :per_page => 50)
    puts "Total number of votes: #{total_votes['count']}"
    batches = (total_votes['count'].to_i / 50.0).ceil
    batches.times do
      votes_ary = client.votes(:voted_at__gte => @last_updated_at, :per_page => 50, :page => page)
      votes = votes_ary['votes']
      puts "==|Batch #{page}|==========================="
      @vote_count = 1
      votes.each do |v|
        puts "Adding votes for #{v.bill_id}..."
        rtc_id = v.bill_id
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
                :vote => vote
              )
            else
              # do nothing
            end
          end
        else
          # do nothing
        end
        @vote_count = @vote_count + 1
      end
      page = page + 1
    end
    Update.create(:task => "votes", :count => @vote_count)
    puts "Added #{@vote_count} votes."
  end

end
