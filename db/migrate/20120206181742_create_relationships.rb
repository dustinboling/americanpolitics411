class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :person_id
      t.integer :family_member_id

      t.timestamps
    end
  end
end
