class CreateEarmarks < ActiveRecord::Migration
  def change
    create_table :earmarks do |t|
      t.integer :person_id
      t.integer :organization_id
      t.text :description
      t.string :sector
      t.integer :amount
      t.date :year

      t.timestamps
    end
    add_index :earmarks, :person_id
    add_index :earmarks, :organization_id
  end
end
