class LegislationCosponsor < ActiveRecord::Base

  attr_accessible :person_id, :legislation_id

  belongs_to :person
  belongs_to :legislation

  def self.exists?(person_id, legislation_id)
    if LegislationCosponsor.find_by_person_id_and_legislation_id(person_id, legislation_id)
      true
    else
      false
    end
  end
  
end
