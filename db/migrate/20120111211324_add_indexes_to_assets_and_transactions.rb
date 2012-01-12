class AddIndexesToAssetsAndTransactions < ActiveRecord::Migration
  def change
    add_index :personal_assets, :organization_id
    add_index :transactions, :organization_id
  end
end
