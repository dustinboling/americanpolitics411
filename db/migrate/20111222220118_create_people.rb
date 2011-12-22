class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.date :date_of_birth
      t.date :date_of_death
      t.string :title
      t.text :bio

      t.timestamps
    end
  end
end
