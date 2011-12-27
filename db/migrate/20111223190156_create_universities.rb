class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :degree_earned
      t.string :name
      t.date :year_completed
      t.integer :person_id
      t.integer :position      

      t.timestamps
    end
    add_index :universities, :person_id
  end
end