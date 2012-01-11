class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :person_id
      t.date :date
      t.string :title
      t.text :description
      t.string :video_url
      t.string :thumbnail_url

      t.timestamps
    end
  end
end