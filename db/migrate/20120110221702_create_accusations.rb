class CreateAccusations < ActiveRecord::Migration
  def change
    create_table :accusations do |t|
      t.integer :person_id
      t.date :date
      t.string :accusation
      t.boolean :outcome

      t.timestamps
    end
    add_index :accusations, :person_id
  end
end
