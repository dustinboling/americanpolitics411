class Issue < ActiveRecord::Base

  attr_accessible :name
  
  has_many :issue_main_issues
  has_many :main_issues, :through => :issue_main_issues  

  def to_param
    "#{id} #{name.capitalize}".parameterize
  end
end
