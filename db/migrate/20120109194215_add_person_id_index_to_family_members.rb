class AddPersonIdIndexToFamilyMembers < ActiveRecord::Migration
  def change
    add_index :family_members, :person_id
  end
end
