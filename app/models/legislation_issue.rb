class LegislationIssue < ActiveRecord::Base
  belongs_to :issue
  belongs_to :legislation
  
end
