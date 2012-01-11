class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :person_id
      t.string :organization_name
      t.boolean :action
      t.date :date
      t.integer :value

      t.timestamps
    end
    add_index :transactions, :person_id
  end
end
