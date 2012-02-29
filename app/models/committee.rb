class Committee < ActiveRecord::Base
  has_many :committee_assignments
  has_many :people, :through => :committee_assignments
  
  has_many :committee_legislations
  has_many :legislations, :through => :committee_legislations
  
  
end