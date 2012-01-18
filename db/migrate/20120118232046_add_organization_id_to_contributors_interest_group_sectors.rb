class AddOrganizationIdToContributorsInterestGroupSectors < ActiveRecord::Migration
  def change
    add_column :contributors_interest_group_sectors, :organization_id, :integer
    add_index :contributors_interest_group_sectors, :organization_id
  end
end
