class PoliticalOffice < ActiveRecord::Base

  attr_accessible :person_id, :office, :date_started, :date_finished
  belongs_to :person
  
end
