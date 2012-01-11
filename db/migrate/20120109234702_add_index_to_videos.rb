class AddIndexToVideos < ActiveRecord::Migration
  def change
    add_index :videos, :person_id
  end
end
