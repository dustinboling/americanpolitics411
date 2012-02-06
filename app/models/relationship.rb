class Relationship < ActiveRecord::Base
  has_many :people
  has_many :family_members
end
