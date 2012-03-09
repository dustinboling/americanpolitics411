class ChangeStateLengthOnEarmarks < ActiveRecord::Migration
  def change
    change_column :earmarks, :house_members, :text 
    change_column :earmarks, :house_parties, :text
    change_column :earmarks, :house_states, :text
    change_column :earmarks, :house_districts, :text
    change_column :earmarks, :senate_members, :text
    change_column :earmarks, :senate_parties, :text
    change_column :earmarks, :senate_states, :text
  end
end
