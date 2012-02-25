class CreateCommitteeAssignments < ActiveRecord::Migration
  def change
    create_table :committee_assignments do |t|
      t.integer :person_id
      t.integer :committee_id
      t.string :year

      t.timestamps
    end
    add_index :committee_assignments, :person_id
    add_index :committee_assignments, :committee_id
  end
end