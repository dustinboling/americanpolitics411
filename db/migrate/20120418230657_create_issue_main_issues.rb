class CreateIssueMainIssues < ActiveRecord::Migration
  def change
    create_table :issue_main_issues do |t|
      t.integer :issue_id
      t.integer :main_issue_id

      t.timestamps
    end
  end
end
