class CreateCommitteeLegislations < ActiveRecord::Migration
  def change
    create_table :committee_legislations do |t|
      t.integer :committee_id
      t.integer :legislation_id
      t.string :congress_year

      t.timestamps
    end
    add_index :committee_legislations, :committee_id
    add_index :committee_legislations, :legislation_id
  end
end
