# == Schema Information
#
# Table name: contributors
#
#  id              :integer         not null, primary key
#  person_id       :integer
#  organization_id :integer
#  amount          :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Contributor < ActiveRecord::Base
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
