class AddFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :professional_experience, :text
    add_column :people, :literary_work, :text
  end
end
