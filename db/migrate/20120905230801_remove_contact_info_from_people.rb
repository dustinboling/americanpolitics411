class RemoveContactInfoFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :contact_street_address
    remove_column :people, :contact_city
    remove_column :people, :contact_state
    remove_column :people, :contact_zip
    remove_column :people, :contact_phone
    remove_column :people, :contact_fax
  end
end
