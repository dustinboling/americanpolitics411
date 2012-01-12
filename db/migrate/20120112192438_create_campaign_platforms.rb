class CreateCampaignPlatforms < ActiveRecord::Migration
  def change
    create_table :campaign_platforms do |t|
      t.integer :person_id
      t.date :campaign_year
      t.string :topic
      t.string :position_on_issue

      t.timestamps
    end
    add_index :campaign_platforms, :person_id
  end
end
