# == Schema Information
#
# Table name: endorsements
#
#  id                :integer         not null, primary key
#  person_id         :integer
#  year              :date
#  organization_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Endorsement < ActiveRecord::Base
  belongs_to :person
  
  def find_organization_name
    Organization.find(organization_id).name
  end
  
end
