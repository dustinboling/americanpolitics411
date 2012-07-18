class CommitteeAssignment < ActiveRecord::Base
  belongs_to :person
  belongs_to :committee
end
