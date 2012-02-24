class CreateLegislationIssues < ActiveRecord::Migration
  def change
    create_table :legislation_issues do |t|
      t.integer :legislation_id
      t.integer :issue_id
      t.string :year

      t.timestamps
    end
    add_index :legislation_issues, :legislation_id
    add_index :legislation_issues, :issue_id
  end
end
