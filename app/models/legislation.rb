class Legislation < ActiveRecord::Base
  has_many :committee_legislations
  has_many :committees, :through => :committee_assignments
  
  has_many :legislation_cosponsors
  has_many :people, :through  => :legislation_cosponsors
end
