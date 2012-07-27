class IssuePosition < ActiveRecord::Base

  attr_accessible :person_id, :issue_topic, :question, :position
  belongs_to :person
  
end
