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
  
end
