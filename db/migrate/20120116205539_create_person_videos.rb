class CreatePersonVideos < ActiveRecord::Migration
  def change
    create_table :person_videos do |t|
      t.integer :person_id
      t.integer :video_id

      t.timestamps
    end
    add_index :person_videos, :person_id
    add_index :person_videos, :video_id
  end
end
