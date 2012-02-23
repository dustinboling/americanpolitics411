class AddChamberToPeople < ActiveRecord::Migration
  def change
    add_column :people, :chamber, :string
  end
end
