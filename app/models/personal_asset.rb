class PersonalAsset < ActiveRecord::Base

  attr_accessible :person_id, :value_min, :value_max, :value, :created_at, :updated_at, :organization_id, :organization_name
  belongs_to :person
  belongs_to :organization
  
 # def organization_name
 #   organization.try(:name)
 # end
 # 
 # def organization_name=(name)
 #   self.organization = Organization.find_or_create_by_name(name) if name.present?
 # end
 # 
 # def find_organization_name
 #   Organization.find(organization_id).name
 # end
  
end
