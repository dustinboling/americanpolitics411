class Person < ActiveRecord::Base
  
  has_many :universities
  
  validates_presence_of :first_name, :last_name, :date_of_birth
  
  scope :sorted, order('people.person_id ASC')
  
end
