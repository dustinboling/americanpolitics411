class RemoveParamsFromActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :params
  end

  def down
  end
end
