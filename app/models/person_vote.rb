class PersonVote < ActiveRecord::Base

  attr_accessible :legislation_id, :person_id, :vote, :voted_at, :how, :result

  belongs_to :person
  belongs_to :legislation

end
