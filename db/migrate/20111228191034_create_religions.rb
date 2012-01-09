class CreateReligions < ActiveRecord::Migration
  def change
    create_table :religions do |t|
      t.string :name
      t.references :person

      t.timestamps
    end
    add_index :religions, :person_id
  end
end
