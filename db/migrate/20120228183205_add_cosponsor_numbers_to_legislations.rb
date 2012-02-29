class AddCosponsorNumbersToLegislations < ActiveRecord::Migration
  def change
    add_column :legislations, :republican_cosponsors, :string
    add_column :legislations, :democratic_cosponsors, :string
  end
end
