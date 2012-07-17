class UpdateLegislationTable < ActiveRecord::Migration
  def up
    add_column :legislations, :rtc_id, :text
    add_column :legislations, :bill_type, :text
    add_column :legislations, :session, :integer
    add_column :legislations, :short_title, :text
    add_column :legislations, :popular_title, :text
  end

  def down
  end
end
