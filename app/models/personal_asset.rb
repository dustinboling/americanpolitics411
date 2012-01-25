# == Schema Information
#
# Table name: personal_assets
#
#  id                :integer         not null, primary key
#  person_id         :integer
#  organization_name :string(255)
#  action            :boolean
#  date              :date
#  value_min         :integer
#  value_max         :integer
#  value             :integer
#  created_at        :datetime
#  updated_at        :datetime
#  organization_id   :integer
#

class PersonalAsset < ActiveRecord::Base
  belongs_to :person
  
  validates_presence_of :action
  
end
