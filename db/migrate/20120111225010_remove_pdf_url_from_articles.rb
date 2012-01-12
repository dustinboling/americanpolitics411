class RemovePdfUrlFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :pdf_url
  end

  def down
    add_column :articles, :pdf_url
  end
end
