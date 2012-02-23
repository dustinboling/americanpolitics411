namespace :seed do  
  
  require 'open-uri'
  
  @@api_key = 'b16efb69e13af05498fe536551a7bc67:15:65673083'
  
  desc "Grab top level list"
  task :house => :environment do
    puts "Getting list of house members for 112th year of congress..."
    house_members_xml = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/112/house/members.xml?api-key=#{@@api_key}"
    @doc = Nokogiri::XML(open(house_members_xml))
    @house_members = @doc.xpath('//id')
    
    puts "Creating profiles..."
    @house_members.map { |member| 
      @id = member.inner_text
      
      def person_exists
        if Person.find_by_nyt_id("#{@id}").nil?
          false
        else
          true
        end
      end
      
      if person_exists
        puts "skipping #{@id}"
      else
        @member_doc = Nokogiri::XML(open("http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/#{@id}.xml?api-key=#{@@api_key}"))
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
            :chamber => "H", 
            :nyt_id => @id
            )
        @person.save
        puts "Added congressman #{@member_doc.xpath('//last_name').inner_text}" 
        sleep 1
      end
      }
      
      puts "All done!"
      
    end
    
    
  end