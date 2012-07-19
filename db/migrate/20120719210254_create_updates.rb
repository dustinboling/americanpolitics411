class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :task
      t.timestamp :utc_timestamp

      t.timestamps
    end
  end
end
