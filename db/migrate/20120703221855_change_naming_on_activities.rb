class ChangeNamingOnActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :object
    remove_column :activities, :object_id
    add_column :activities, :resource_type, :string
    add_column :activities, :resource_id, :integer
  end

  def down
  end
end
