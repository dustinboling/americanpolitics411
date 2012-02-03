class RemoveFromPersonalAssetsTransactions < ActiveRecord::Migration
  def change
    remove_column :personal_assets, :organization_name
    remove_column :personal_assets, :action
    remove_column :personal_assets, :date
    remove_column :transactions, :organization_name
  end
end
