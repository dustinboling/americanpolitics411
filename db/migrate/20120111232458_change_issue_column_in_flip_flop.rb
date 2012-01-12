class ChangeIssueColumnInFlipFlop < ActiveRecord::Migration
  def up
    change_column :flip_flops, :issue, :text
  end

  def down
    change_column :flip_flops, :issue, :string
  end
end
