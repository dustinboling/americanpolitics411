class CreateSponsoredLegislations < ActiveRecord::Migration
  def change
    create_table :sponsored_legislations do |t|
      t.integer :person_id
      t.boolean :sponsor
      t.string :bill_number
      t.date :year_of_congress
      t.string :url

      t.timestamps
    end
    add_index :sponsored_legislations, :person_id
  end
end
