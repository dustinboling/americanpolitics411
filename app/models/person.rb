class Person < ActiveRecord::Base
  
  validates_presence_of :first_name, :last_name, :date_of_birth
  
  # here are some scopes for if
  scope :dead, where(:is_dead => true)
  scope :not_dead, where(:is_dead => false)
  
end
