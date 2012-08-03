class AddOrganizationNameToPersonalAssets < ActiveRecord::Migration
  def change
    add_column :personal_assets, :organization_name, :text
  end
end
