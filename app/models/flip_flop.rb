class FlipFlop < ActiveRecord::Base

  attr_accessible :person_id, :year, :issue, :flipflop
  belongs_to :person
  
end
