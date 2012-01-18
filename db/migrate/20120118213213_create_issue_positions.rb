class CreateIssuePositions < ActiveRecord::Migration
  def change
    create_table :issue_positions do |t|
      t.integer :person_id
      t.string :issue_topic
      t.string :question
      t.string :position

      t.timestamps
    end
    add_index :issue_positions, :person_id
  end
end
