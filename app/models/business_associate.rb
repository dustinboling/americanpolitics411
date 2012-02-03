# == Schema Information
#
# Table name: business_associates
#
#  id                    :integer         not null, primary key
#  organization_id       :integer
#  person_id             :integer
#  full_name             :string(255)
#  position              :string(255)
#  business_relationship :text
#  created_at            :datetime
#  updated_at            :datetime
#

class BusinessAssociate < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  
  def organization_name
    organization.try(:name)
  end
  
  def organization_name=(name)
    self.organization = Organization.find_or_create_by_name(name) if name.present?
  end
  
  def find_organization_name
    Organization.find(organization_id).name
  end
  
end
