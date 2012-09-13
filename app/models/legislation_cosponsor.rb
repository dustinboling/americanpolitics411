class LegislationCosponsor < ActiveRecord::Base

  attr_accessible :person_id, :legislation_id

  belongs_to :person
  belongs_to :legislation
  
end
