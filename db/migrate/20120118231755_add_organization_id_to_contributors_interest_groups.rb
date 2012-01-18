class AddOrganizationIdToContributorsInterestGroups < ActiveRecord::Migration
  def change
    add_column :contributors_interest_groups, :organization_id, :integer
    add_index :contributors_interest_groups, :organization_id
  end
end
