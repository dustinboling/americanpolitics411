class AddNytIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :nyt_id, :string
  end
end
