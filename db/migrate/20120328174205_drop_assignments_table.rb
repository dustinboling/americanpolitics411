class DropAssignmentsTable < ActiveRecord::Migration
  def up
    drop_table :assignments
  end

  def down
  end
end
