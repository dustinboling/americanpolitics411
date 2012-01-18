class AddOrganizationIdToContributorsPacs < ActiveRecord::Migration
  def change
    add_column :contributors_pacs, :organization_id, :integer
    add_index :contributors_pacs, :organization_id
  end
end
