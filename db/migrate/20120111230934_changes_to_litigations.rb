class ChangesToLitigations < ActiveRecord::Migration
  def up
    change_column :litigations, :litigation, :text
    change_column :litigations, :outcome, :text
  end

  def down
    change_column :litigations, :litigation, :string
    change_column :litigations, :outcome, :boolean
  end
end
