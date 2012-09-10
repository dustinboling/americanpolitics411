class OrganizationPerson < ActiveRecord::Base

  attr_accessible :position, :person_id, :organization_id

  belongs_to :person
  belongs_to :organization

end
