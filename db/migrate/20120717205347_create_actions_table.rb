class CreateActionsTable < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :legislation_id
      t.text :text
      t.timestamp :acted_at
      
      t.timestamps
    end
  end
end
