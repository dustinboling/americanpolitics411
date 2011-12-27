class University < ActiveRecord::Base
  
  belongs_to :person
  
  scope :sorted, order('universities.id ASC')
  
end
