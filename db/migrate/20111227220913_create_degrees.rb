class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.references :university
      t.references :person
      t.string :degree_earned
      t.date :year_earned

      t.timestamps
    end
    add_index :degrees, :university_id
    add_index :degrees, :person_id
  end
end
