class AddIsCongressMemberToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_congress_member, :boolean
  end
end
