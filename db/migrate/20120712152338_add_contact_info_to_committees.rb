class AddContactInfoToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :contact_info, :text
  end
end
