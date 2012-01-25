class ChangeReligionDefaultTo7OnPeople < ActiveRecord::Migration
  def change
    change_column :people, :religion_id, :integer, :null => false, :default => 7
  end
end
