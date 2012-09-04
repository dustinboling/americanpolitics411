module LegislationHelper
  def remove_hyphens(string)
     string.gsub(/-/, "").gsub(/!/, "").gsub(/'/, "")
  end

  def parse_summary(summary)
    summary_sp1 = summary.split('. ').join('. <br>') 
    summary_sp2 = summary_sp1.split('.').join('.<br>')
    summary_sp3 = summary_sp2.split(': ').join(': <br>')
    summary_sp4 = summary_sp3.split('(').join('<br>(')
    summary = summary_sp4.html_safe

    return summary
  end
end

