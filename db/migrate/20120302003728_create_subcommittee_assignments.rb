class CreateSubcommitteeAssignments < ActiveRecord::Migration
  def change
    create_table :subcommittee_assignments do |t|
      t.integer :person_id
      t.integer :subcommittee_id

      t.timestamps
    end
    add_index :subcommittee_assignments, :person_id
    add_index :subcommittee_assignments, :subcommittee_id
  end
end