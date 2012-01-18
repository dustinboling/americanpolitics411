class AddOrganizationIdToEndorsements < ActiveRecord::Migration
  def change
    remove_column :endorsements, :organization_name
    add_column :endorsements, :organization_id, :integer
    add_index :endorsements, :organization_id
  end
end
