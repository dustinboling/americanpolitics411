class AddReligionIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :religion_id, :integer
  end
end
