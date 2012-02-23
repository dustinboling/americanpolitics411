class AddMoreFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :gender, :string
    add_column :people, :times_topics_url, :string
    add_column :people, :govtrack_id, :string
    add_column :people, :cspan_id, :string
    add_column :people, :icpsr_id, :string
    add_column :people, :twitter_id, :string
    add_column :people, :youtube_id, :string
    add_column :people, :current_party, :string
  end
end
