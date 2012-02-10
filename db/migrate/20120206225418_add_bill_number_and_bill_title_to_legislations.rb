class AddBillNumberAndBillTitleToLegislations < ActiveRecord::Migration
  def change
    add_column :legislations, :bill_number, :string
    add_column :legislations, :bill_title, :string
  end
end
