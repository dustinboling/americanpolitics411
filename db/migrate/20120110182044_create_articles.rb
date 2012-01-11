class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :person_id
      t.string :title
      t.text :excerpt
      t.string :article_url
      t.string :pdf_url
      t.date :date

      t.timestamps
    end
    add_index :articles, :person_id
  end
end