class Litigation < ActiveRecord::Base
  attr_accessible :person_id, :date, :litigation, :outcome

  belongs_to :person
end
