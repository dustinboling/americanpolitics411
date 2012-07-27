class Accusation < ActiveRecord::Base

  attr_accessible :person_id, :date, :accusation, :outcome
  belongs_to :person
  
end
