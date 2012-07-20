class AddCountToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :count, :integer
  end
end
