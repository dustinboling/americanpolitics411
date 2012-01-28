class AddFamilyMemberIdToFamilyMembers < ActiveRecord::Migration
  def change
    add_column :family_members, :family_member, :integer
  end
end
