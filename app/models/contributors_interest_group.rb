# == Schema Information
#
# Table name: contributors_interest_groups
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  name       :string(255)
#  amount     :integer
#  year       :date
#  created_at :datetime
#  updated_at :datetime
#

class ContributorsInterestGroup < ActiveRecord::Base
  belongs_to :person
  
  def find_organization_name
    Organization.find(organization_id).name
  end
  
end
