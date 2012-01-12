class AddOrganizationIdToAssetsAndTransactions < ActiveRecord::Migration
  def change
    add_column :personal_assets, :organization_id, :integer
    add_column :transactions, :organization_id, :integer
  end
end
