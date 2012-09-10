class AddTitleToPeople < ActiveRecord::Migration
  def change
    add_column :people, :title, :text
  end
end
