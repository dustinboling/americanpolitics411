class DropUnneccessaryTables < ActiveRecord::Migration
  def up
    drop_table :contributors
    drop_table :contributors_interest_groups
    drop_table :contributors_interest_group_sectors
    drop_table :contributors_pacs
  end

  def down
  end
end
