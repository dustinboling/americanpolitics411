class CommitteeAssignment < ActiveRecord::Base

  attr_accessible :committee_id, :person_id

  belongs_to :person
  belongs_to :committee
end
