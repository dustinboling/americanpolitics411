class CreateLegislativeOffices < ActiveRecord::Migration
  def change
    create_table :legislative_offices do |t|
      t.integer :person_id
      t.string :congress_year
      t.string :chamber
      t.string :state
      t.string :district
      t.string :party
      t.string :seniority
      t.string :start_date
      t.string :end_date
      t.integer :bills_sponsored
      t.integer :bills_cosponsored
      t.string :missed_votes_pct
      t.string :votes_with_party_pct

      t.timestamps
    end
    add_index :legislative_offices, :person_id
  end
end
