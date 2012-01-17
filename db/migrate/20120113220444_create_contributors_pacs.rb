class CreateContributorsPacs < ActiveRecord::Migration
  def change
    create_table :contributors_pacs do |t|
      t.integer :person_id
      t.string :name
      t.integer :amount

      t.timestamps
    end
    add_index :contributors_pacs, :person_id
  end
end
