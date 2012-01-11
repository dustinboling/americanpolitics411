class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.integer :person_id
      t.date :year
      t.string :organization_name

      t.timestamps
    end
  end
end
