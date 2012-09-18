class PersonVote < ActiveRecord::Base

  attr_accessible :legislation_id, :person_id, :vote, :voted_at, :how, :result

  belongs_to :person
  belongs_to :legislation

  def self.does_not_exist(legislation_id, person_id, voted_at)
    if self.find_by_legislation_id_and_person_id_and_voted_at(legislation_id, person_id, voted_at)
      false
    else
      true
    end
  end

end
