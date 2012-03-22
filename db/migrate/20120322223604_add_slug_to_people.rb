class AddSlugToPeople < ActiveRecord::Migration
  def change
    add_column :people, :slug, :text
  end
end
