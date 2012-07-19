class CreatePersonVotes < ActiveRecord::Migration
  def change
    create_table :person_votes do |t|
      t.integer :person_id
      t.integer :legislation_id
      t.text :vote

      t.timestamps
    end
    add_index :person_votes, :person_id
  end
end
