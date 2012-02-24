class AddFieldsToLegislations < ActiveRecord::Migration
  def change
    add_column :legislations, :introduced_date, :string
    add_column :legislations, :latest_major_action_date, :string
    add_column :legislations, :latest_major_action, :string
    add_column :legislations, :bill_sponsor, :string
    add_column :legislations, :bill_sponsor_id, :string
    add_column :legislations, :bill_pdf, :text
  end
end
