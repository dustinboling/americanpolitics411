module PeopleHelper
  def no_separator
    options={:words_connector => '', :two_words_connector => '', :last_word_connector => ''}
  end

  def party_breakdown
    if @id.nil?
      "N/A"
    else
      @stats = TransparencyData::Client.individual_party_breakdown(@id)
      @dem_count = @stats.dem_count.to_f
      @rep_count = @stats.rep_count.to_f
      @dem_percent = (@dem_count / (@dem_count + @rep_count)) * 100
      @rep_percent = (@rep_count / (@dem_count + @rep_count)) * 100
      if @dem_percent > @rep_percent
        "<p>#{sprintf("%0.02f", @dem_percent)}% Democratic (#{@dem_count.to_i})</p>
         <p>#{sprintf("%0.02f", @rep_percent)}% Republican (#{@rep_count.to_i})</p>".html_safe
      elsif @dem_percent == @rep_percent
        "<p>#{sprintf("%0.02f", @dem_percent)}% Democratic (#{@dem_count.to_i})</p>
         <p>#{sprintf("%0.02f", @rep_percent)}% Republican (#{@rep_count.to_i})</p>".html_safe
      else
        "<p>#{sprintf("%0.02f", @rep_percent)}% Republican (#{@rep_count.to_i})</p>
         <p>#{sprintf("%0.02f", @dem_percent)}% Democratic (#{@dem_count.to_i})</p>".html_safe
      end
    end
  end

  def state_federal_breakdown
    if @id.nil?
      "N/A"
    else
      @stats = TransparencyData::Client.org_level_breakdown(@id)
      @fed_amount = @stats.federal_amount
      @state_amount = @stats.state_amount
      @fed_count = @stats.federal_count.to_f
      @state_count = @stats.state_count.to_f
      @fed_percent = (@fed_count / (@fed_count + @state_count)) * 100
      @state_percent = (@state_count / (@fed_count + @state_count)) * 100
      "<p>Federal Contributions: #{sprintf("%0.02f", @fed_percent)}% (#{number_to_currency(@fed_amount)})</p>
       <p>State Contributions: #{sprintf("%0.02f", @state_percent)}% (#{number_to_currency(@state_amount)})</p>".html_safe
    end
  end

  def contributions_by_sector_math
    @i = 0
    @sectors.each do |s|
      @i = @i + s.amount.to_i
    end    
  end

  def get_tweet_ids
    @tweet_ids = []
    @tweet_text = []
    @tweets = @recent_tweets.each do |t|
      @tweet_ids << t.id
    end
  end

  def bubble_safe(str, opts={})
    opts[:width] ||= 80
    zero_width_space = "&#8203;"
      regex = /.{1,#{opts[:width]}}/
      (str.length < opts[:width]) ? text :
      str.scan(regex).join(zero_width_space)
  end

  def js_safe(html)
    html.html_safe.gsub(/\r/, "\\r").gsub(/\n/, "\\n") 
  end

  def print_contact_info
    contact_info = @person.contact_phone
  end

  def fetch_json(url)
    require 'json'
    require 'net/http'

    begin
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      json = JSON.parse(data)

      return json
    rescue Exception => e
    end
  end

  def fetch_pfd_profile(person)
    require 'json'
    require 'net/http'

    apikey = "3c994a55a6b79f30f22b6b3942941f62"
    endpoint = "http://www.opensecrets.org/api/?method=memPFDprofile"

    cid = person.crp_id

    if cid.nil?
      cid = get_crp_id(person.last_name)
      if cid.empty?
        return []
      else
        person.crp_id = cid
        person.save
      end
      url = endpoint + "&year=2009&cid=" + cid + "&output=json&apikey=" + apikey
      json = fetch_json(url)

      return json
    else
      url = endpoint + "&year=2009&cid=" + cid + "&output=json&apikey=" + apikey
      json = fetch_json(url)

      return json
    end
  end

  def fetch_net_worth(person)
    json = fetch_pfd_profile(person)
    if json.empty?
      return []
    else
      json_attributes = json['response']['member_profile']['@attributes']
      @net_worth_minimum = json_attributes['net_low'].to_i
      @net_worth_maximum = json_attributes['net_high'].to_i
      @net_worth_average = (@net_worth_maximum + @net_worth_minimum) / 2
    end

    return @net_worth_minimum, @net_worth_maximum, @net_worth_average
  end

  def fetch_votes(person)
    nyt_apikey = "b16efb69e13af05498fe536551a7bc67:15:65673083"
    nyt_endpoint = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/"
    if person.bioguide_id.nil?
      @bioguide_id = get_bioguide_id(person.last_name)
      if @bioguide_id.empty?
        return []
      else
        # save the bioguide id
        person.bioguide_id = @bioguide_id
        person.save

        nyt_url = nyt_endpoint + @bioguide_id + "/votes.json?api-key=" + nyt_apikey
        json = fetch_json(nyt_url)

        return json
      end
    else
      @bioguide_id = person.bioguide_id
      nyt_url = nyt_endpoint + @bioguide_id + "/votes.json?api-key=" + nyt_apikey
      json = fetch_json(nyt_url)

      return json
    end
  end

  def get_bioguide_id(name)
    govtrack_endpoint = "http://www.govtrack.us/api/v1/person/?lastname=" + name
    govtrack_json = fetch_json(govtrack_endpoint)
    govtrack_count = govtrack_json['meta']['total_count']
    if govtrack_count > 0 && govtrack_count < 2
      bioguide_id = govtrack_json['objects'][0]['bioguideid']
      return bioguide_id
    else
      return []
    end
  end

  def get_crp_id(name)
    # get the crp_id using firstname, lastname, nameod
    govtrack_endpoint = "http://www.govtrack.us/api/v1/person/?lastname=" + name
    govtrack_json = fetch_json(govtrack_endpoint)
    govtrack_count = govtrack_json['meta']['total_count']

    if govtrack_count > 0 && govtrack_count < 2
      crp_id = govtrack_json['objects'][0]['osid']
      return crp_id
    else
      return []
    end
  end

  def parse_google_rss_feed(full_name, options={})
    options[:num] ||= 10
    full_name = full_name.gsub(/ /, "%20")
    endpoint = "http://news.google.com/news?q=" 
    url = endpoint + full_name + "&output=rss&num=" + options[:num].to_s
    feed = Feedzirra::Feed.fetch_and_parse(url)
    articles = feed.entries

    return articles
  end

  def parse_google_summary(summary)
    doc = Nokogiri::HTML(summary)
    summary = doc.xpath('//div/font[2]').inner_text

    return summary
  end

  def parse_book(b)
    book = b.get_hash
    attributes = "<Book>" + book["ItemAttributes"] + "</Book>"
    book_attributes = Nokogiri::XML(attributes)
    @url = book["DetailPageURL"]
    @title = book_attributes.xpath('//Title').inner_text
    @author = book_attributes.xpath('//Author').inner_text
    unless b.get_hash('SmallImage').nil?
      @image = b.get_hash('SmallImage')["URL"]
    end

    return @url, @title, @author, @image
  end

  def get_demographics(person)
    begin
      @entity = TransparencyData::Client.entities(:search => "#{person.remove_name_numericality}")
      if @entity.empty?
        @entity = TransparencyData::Client.id_lookup(:namespace => "urn:crp:recipient", :id => person.crp_id)
      end

      if @entity.first
        @id = @entity.first.id
        @sectors = TransparencyData::Client.top_sectors(@id)
      else
        @sectors = []
      end
    rescue Exception => e
      @success = false
    end

    return @sectors, @id, @success, @entity
  end

  def load_demographic_pie_percentages(sectors)
    contributions_by_sector_math
    @demographic_pie_percentages = [] 
    @legend = []
    @sectors.collect do |s|
      percentage = sprintf("%0.02f", ((s.amount.to_f / @i.to_f)) * 100).to_f
      percentage_as_percent = number_to_percentage(percentage, :precision => 2)
      legend = percentage_as_percent + " " + s.name + " - (#{number_to_currency(s.amount)})"
      @demographic_pie_percentages << percentage
      @legend << legend
    end

    return @demographic_pie_percentages, @legend
  end

end
