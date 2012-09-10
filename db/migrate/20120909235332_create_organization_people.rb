class CreateOrganizationPeople < ActiveRecord::Migration
  def change
    create_table :organization_people do |t|
      t.integer :organization_id
      t.integer :person_id
      t.text :position

      t.timestamps
    end
    add_index :organization_people, :organization_id
    add_index :organization_people, :person_id
  end
end
