class DropEvenMoreTables < ActiveRecord::Migration
  def up
    drop_table :attachments
    drop_table :person_videos
    drop_table :professional_experiences
    drop_table :sponsored_legislations
    drop_table :videos
  end

  def down
  end
end
