class AddSummaryToLegislation < ActiveRecord::Migration
  def change
    add_column :legislations, :summary, :text
  end
end
