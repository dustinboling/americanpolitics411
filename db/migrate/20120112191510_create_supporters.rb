class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.string :group_name
      t.string :support_percentage
      t.integer :person_id

      t.timestamps
    end
    add_index :supporters, :person_id
  end
end
