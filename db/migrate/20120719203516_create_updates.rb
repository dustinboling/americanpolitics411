class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.timestamp :last_update
      t.string :suntime

      t.timestamps
    end
  end
end
