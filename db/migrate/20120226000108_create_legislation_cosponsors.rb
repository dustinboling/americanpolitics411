class CreateLegislationCosponsors < ActiveRecord::Migration
  def change
    create_table :legislation_cosponsors do |t|
      t.integer :person_id
      t.integer :legislation_id

      t.timestamps
    end
    add_index :legislation_cosponsors, :person_id
    add_index :legislation_cosponsors, :legislation_id
  end
end
