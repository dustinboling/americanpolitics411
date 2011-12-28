class Person < ActiveRecord::Base
  
  has_many :universities, :through => :degrees
  has_many :degrees
  
  validates_presence_of :first_name, :last_name, :date_of_birth
  
  scope :sorted, order('people.person_id ASC')

end
