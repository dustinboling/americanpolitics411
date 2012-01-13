class CreatePoliticalOffices < ActiveRecord::Migration
  def change
    create_table :political_offices do |t|
      t.integer :person_id
      t.string :position
      t.string :district
      t.string :office
      t.date :date_started
      t.date :date_finished

      t.timestamps
    end
  end
end
