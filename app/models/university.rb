class University < ActiveRecord::Base
  
  has_many :people
  has_many :degrees
  
  scope :sorted, order('universities.id ASC')
  
end
