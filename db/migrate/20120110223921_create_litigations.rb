class CreateLitigations < ActiveRecord::Migration
  def change
    create_table :litigations do |t|
      t.integer :person_id
      t.date :date
      t.string :litigation
      t.boolean :outcome

      t.timestamps
    end
    add_index :litigations, :person_id
  end
end