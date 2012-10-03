class AddIndexToPersonIdOnAddresses < ActiveRecord::Migration
  def change
    add_index :addresses, :person_id
  end
end
