class Subcommittee < ActiveRecord::Base

  attr_accessible :name, :code, :chamber, :committee_id

  belongs_to :committee
  
  has_many :subcommittee_assignments
  has_many :people, :through => :subcommittee_assignments
  
end
