class CampaignPlatform < ActiveRecord::Base

  attr_accessible :person_id, :campaign_year, :topic, :position_on_issue
  belongs_to :person
  
end
