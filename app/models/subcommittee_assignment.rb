class SubcommitteeAssignment < ActiveRecord::Base
  belongs_to :subcommittee
  belongs_to :person
end
