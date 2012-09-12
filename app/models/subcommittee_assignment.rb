class SubcommitteeAssignment < ActiveRecord::Base

  attr_accessible :person_id, :subcommittee_id

  belongs_to :subcommittee
  belongs_to :person

end
