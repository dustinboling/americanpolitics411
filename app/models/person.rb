class Person < ActiveRecord::Base
  
  has_many :universities, :through => :degrees
  has_many :degrees
  belongs_to :religion
  has_many :family_members
  
  
  validates_presence_of :first_name, :last_name, :date_of_birth, :religion
  
  scope :sorted, order('people.person_id ASC')
  
end
