class Subcommittee < ActiveRecord::Base
  belongs_to :committee
  
  has_many :subcommittee_assignments
  has_many :people, :through => :subcommittee_assignments
  
end
