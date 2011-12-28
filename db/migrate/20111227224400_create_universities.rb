class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.references :person
      t.references :degree

      t.timestamps
    end
    add_index :universities, :person_id
    add_index :universities, :degree_id
  end
end
