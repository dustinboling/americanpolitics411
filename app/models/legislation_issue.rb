class LegislationIssue < ActiveRecord::Base

  attr_accessible :issue_id, :legislation_id

  belongs_to :issue
  belongs_to :legislation
  
end
