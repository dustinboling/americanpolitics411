class LegislationIssue < ActiveRecord::Base

  attr_accessible :issue_id, :legislation_id

  belongs_to :issue
  belongs_to :legislation

  def self.does_not_exist(legislation_id, issue_id)
    if LegislationIssue.find_by_legislation_id_and_issue_id(legislation_id, issue_id)
      false
    else
      true
    end
  end
  
end
