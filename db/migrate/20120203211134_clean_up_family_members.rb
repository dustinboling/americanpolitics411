class CleanUpFamilyMembers < ActiveRecord::Migration
  def change
    remove_column :family_members, :name
  end
end
