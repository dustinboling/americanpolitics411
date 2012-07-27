class University < ActiveRecord::Base

  attr_accessible :name
  
  validates_presence_of :name
  
  has_many :people, :through => :degrees
  has_many :degrees
  
  scope :sorted, order('universities.id ASC')
  
end
