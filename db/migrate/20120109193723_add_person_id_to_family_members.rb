class AddPersonIdToFamilyMembers < ActiveRecord::Migration
  def change
    add_column :family_members, :person_id, :integer
  end
end
