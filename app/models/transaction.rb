class Transaction < ActiveRecord::Base
  belongs_to :person
  
  validates_presence_of :person, :value, :action
  validates_numericality_of :value
  
end
