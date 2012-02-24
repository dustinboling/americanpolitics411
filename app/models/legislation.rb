class Legislation < ActiveRecord::Base
  has_many :committee_legislations
  has_many :committees, :through => :committee_assignments
  
end
