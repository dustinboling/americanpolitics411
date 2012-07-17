class AddChamberToLegislations < ActiveRecord::Migration
  def change
    add_column :legislations, :chamber, :text
  end
end
