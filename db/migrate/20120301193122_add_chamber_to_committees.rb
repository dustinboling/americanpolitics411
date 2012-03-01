class AddChamberToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :chamber, :string
  end
end
