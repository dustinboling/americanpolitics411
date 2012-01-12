class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.integer :person_id
      t.integer :organization_id
      t.integer :amount

      t.timestamps
    end
  end
end
