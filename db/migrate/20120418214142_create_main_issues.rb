class CreateMainIssues < ActiveRecord::Migration
  def change
    create_table :main_issues do |t|
      t.string :name

      t.timestamps
    end
  end
end
