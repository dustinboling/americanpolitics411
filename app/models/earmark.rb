# == Schema Information
#
# Table name: earmarks
#
#  id              :integer         not null, primary key
#  person_id       :integer
#  organization_id :integer
#  description     :text
#  sector          :string(255)
#  amount          :integer
#  year            :date
#  created_at      :datetime
#  updated_at      :datetime
#

class Earmark < ActiveRecord::Base
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
