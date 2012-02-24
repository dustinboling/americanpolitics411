class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :name
      t.string :code
      t.string :nyt_uri

      t.timestamps
    end
  end
end
