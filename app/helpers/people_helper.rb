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
      @rep_percent =( @rep_count / (@dem_count + @rep_count)) * 100
      if @dem_percent > @rep_percent
        "<p>#{@dem_percent}% Democratic</p>
         <p>#{@rep_percent}% Democratic</p>".html_safe
      elsif @dem_percent == @rep_percent
        "<p>#{@dem_percent}% Democratic</p>
         <p>#{@rep_percent}% Democratic</p>".html_safe
      else
        "<p>#{@rep_percent}% Democratic</p>
         <p>#{@dem_percent}% Democratic</p>".html_safe
      end
    end
  end
  
end
