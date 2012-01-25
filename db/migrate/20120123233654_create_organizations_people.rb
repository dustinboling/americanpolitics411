class CreateOrganizationsPeople < ActiveRecord::Migration
    def change
      create_table :organizations_people do |t|
        t.integer :person_id
        t.integer :organization_id

        t.timestamps
      end
      add_index :organizations_people, :person_id
      add_index :organizations_people, :organization_id
    end
end