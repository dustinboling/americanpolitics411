class AddWebformAndEventfulIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :eventful_id, :text
    add_column :people, :official_rss, :text
    add_column :people, :webform, :text
    add_column :people, :nickname, :text
    add_column :people, :bioguide_id, :text
    add_column :people, :senate_class, :text
    add_column :people, :congresspedia_url, :text
  end
end
