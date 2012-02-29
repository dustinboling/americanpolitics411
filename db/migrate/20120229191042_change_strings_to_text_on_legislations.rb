class ChangeStringsToTextOnLegislations < ActiveRecord::Migration
  def up
    change_column :legislations, :latest_major_action, :text
  end

  def down
    change_column :legislations, :latest_major_action, :string
  end
end
