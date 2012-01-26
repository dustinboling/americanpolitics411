class CreateLegislations < ActiveRecord::Migration
  def change
    create_table :legislations do |t|
      t.string :bill_uri
      
      t.timestamps
    end
    add_index :legislations, :bill_uri
  end
end
