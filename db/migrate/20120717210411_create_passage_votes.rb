class CreatePassageVotes < ActiveRecord::Migration
  def change
    create_table :passage_votes do |t|
      t.integer :legislation_id
      t.text :result
      t.timestamp :voted_at
      t.text :passage_type
      t.text :text
      t.text :how
      t.text :roll_id
      t.text :chamber
      
      t.timestamps
    end
  end
end
