class CreateContributorsInterestGroups < ActiveRecord::Migration
  def change
    create_table :contributors_interest_groups do |t|
      t.integer :person_id
      t.string :name
      t.integer :amount
      t.date :year

      t.timestamps
    end
    add_index :contributors_interest_groups, :person_id
  end
end
