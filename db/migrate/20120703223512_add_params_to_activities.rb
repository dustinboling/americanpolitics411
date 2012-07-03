class AddParamsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :params, :text
  end
end
