class Committee < ActiveRecord::Base
  
  attr_accessible :name, :code, :chamber 
  
  has_many :subcommittees
  
  has_many :committee_assignments
  has_many :people, :through => :committee_assignments
  
  has_many :committee_legislations
  has_many :legislations, :through => :committee_legislations
  
  
end
