class Organization < ActiveRecord::Base
  
  validates_uniqueness_of :name
  
  has_many :people
  
  
end
