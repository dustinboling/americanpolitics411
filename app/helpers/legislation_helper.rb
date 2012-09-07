module LegislationHelper
  def remove_hyphens(string)
    string.gsub(/-/, "").gsub(/!/, "").gsub(/'/, "")
  end

  def parse_summary(summary)
    # TODO: summary_sp1 and summary_sp2 basically do nothing, we need to
    # look ahead and make sure that the NEXT NON DIGIT CHARACTER is
    # not a ")" or "}"
    summary_sp1 = summary.split('. *?![^\)]').join('. <br>') 
    summary_sp2 = summary_sp1.split('.*?![^\)]').join('.<br>')
    summary_sp3 = summary_sp2.split(': ').join(': <br>')
    summary_sp4 = summary_sp3.split(/\((?=\d)/).join('<br>(')
    summary_sp5 = summary_sp4.split('. (').join('. <br>(')
    summary_sp6 = summary_sp5.split(/\. (?=\D)/).join('. <br>')
    summary = summary_sp5.html_safe

    return summary
  end

  def get_vote_breakdown
  end

  def split_voter_ids
    voter_ids = @votes['votes'].last['voter_ids']
    yeas = []
    nays = []
    abstains = []

    # split up into yeas, nays, abstains
    voter_ids.each do |id|
      if id[1] == 'Yea'
        yeas << id[0]
      elsif id[1] == 'Nay'
        nays << id[0]
      elsif id[1] == 'Not Voting'
        abstains << id[0]
      end
    end

    # compose sql statements
    find_yeas = "SELECT * FROM people WHERE "
    find_nays = "SELECT * FROM people WHERE "
    find_abstains = "SELECT * FROM people WHERE "

    yeas_length = yeas.length
    nays_length = nays.length
    abstains_length = abstains.length

    i = 0
    yeas.each do |y|
      if i == yeas_length - 1
        find_yeas = find_yeas + 
          "bioguide_id = '#{y.capitalize}'"
      else
        find_yeas = find_yeas + 
          "bioguide_id = '#{y.capitalize}' OR "
        i = i + 1
      end
    end
    @yeas = Person.find_by_sql(find_yeas)

    i = 0
    nays.each do |n|
      if i == nays_length - 1
        find_nays = find_nays + 
          "bioguide_id = '#{n.capitalize}'"
      else
        find_nays = find_nays + 
          "bioguide_id = '#{n.capitalize}' OR "
        i = i + 1
      end
    end
    @nays = Person.find_by_sql(find_nays)

    i = 0
    abstains.each do |a|
      if i == abstains_length - 1
        find_abstains = find_abstains + "bioguide_id = '#{a.capitalize}'"
      else
        find_abstains = find_abstains + 
          "bioguide_id = '#{a.capitalize}' OR "
        i = i + 1
      end
    end
    @abstains = Person.find_by_sql(find_abstains)

    return @yeas, @nays, @abstains
  end

end
