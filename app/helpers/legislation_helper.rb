module LegislationHelper
  def remove_hyphens(string)
     string.gsub(/-/, "").gsub(/!/, "").gsub(/'/, "")
  end
end

