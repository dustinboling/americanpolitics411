class ChangesToAccusations < ActiveRecord::Migration
  def up
    change_column :accusations, :accusation, :text
    change_column :accusations, :outcome, :text
  end

  def down
    change_column :accusations, :accusation, :string
    change_column :accusations, :outcome, :boolean
  end
end