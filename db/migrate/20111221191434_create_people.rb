class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :current_title
      t.text :issues
      t.text :memberships
      t.text :committee_assignments

      t.timestamps
    end
  end
end
