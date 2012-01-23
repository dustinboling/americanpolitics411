# == Schema Information
#
# Table name: contributors_pacs
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  name       :string(255)
#  amount     :integer
#  created_at :datetime
#  updated_at :datetime
#  year       :date
#

class ContributorsPac < ActiveRecord::Base
  belongs_to :person
  
  def find_organization_name
    Organization.find(organization_id).name
  end
  
end
