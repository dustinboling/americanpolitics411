class CreateBusinessAssociates < ActiveRecord::Migration
  def change
    create_table :business_associates do |t|
      t.integer :organization_id
      t.integer :person_id
      t.string :full_name
      t.string :position
      t.text :business_relationship

      t.timestamps
    end
    add_index :business_associates, :organization_id
    add_index :business_associates, :person_id
  end
end
