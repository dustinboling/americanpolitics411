class DropArticlesTable < ActiveRecord::Migration
  def up
    drop_table :articles
  end

  def down
  end
end
