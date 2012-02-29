class Legislation < ActiveRecord::Base
  has_many :committee_legislations
  has_many :committees, :through => :committee_legislations
  
  has_many :legislation_cosponsors
  has_many :people, :through  => :legislation_cosponsors
  
  has_many :legislation_issues
  has_many :issues, :through => :legislation_issues
  
  
end
