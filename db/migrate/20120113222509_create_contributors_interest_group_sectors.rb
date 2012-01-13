class CreateContributorsInterestGroupSectors < ActiveRecord::Migration
  def change
    create_table :contributors_interest_group_sectors do |t|
      t.integer :person_id
      t.string :name
      t.integer :amount
      t.date :year

      t.timestamps
    end
    add_index :contributors_interest_group_sectors, :person_id
  end
end
