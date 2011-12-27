class University < ActiveRecord::Base
  
  has_and_belongs_to_many :people
  has_many :degrees
  
  scope :sorted, order('universities.id ASC')
  
end
