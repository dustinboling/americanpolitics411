class CreatePersonalAssets < ActiveRecord::Migration
  def change
    create_table :personal_assets do |t|
      t.integer :person_id
      t.string :organization_name
      t.boolean :action
      t.date :date
      t.integer :value_min
      t.integer :value_max
      t.integer :value

      t.timestamps
    end
    add_index :personal_assets, :person_id
  end
end