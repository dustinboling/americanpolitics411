# == Schema Information
#
# Table name: campaign_platforms
#
#  id                :integer         not null, primary key
#  person_id         :integer
#  campaign_year     :date
#  topic             :string(255)
#  position_on_issue :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class CampaignPlatform < ActiveRecord::Base
  belongs_to :person
  
end
