class CreateProfessionalExperiences < ActiveRecord::Migration
  def change
    create_table :professional_experiences do |t|
      t.integer :person_id
      t.integer :organization_id
      t.string :position
      t.date :date_started
      t.date :date_ended
      t.text :accomplishments

      t.timestamps
    end
    add_index :professional_experiences, :person_id
    add_index :professional_experiences, :organization_id
  end
end
