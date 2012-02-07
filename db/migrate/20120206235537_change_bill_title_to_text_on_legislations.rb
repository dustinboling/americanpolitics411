class ChangeBillTitleToTextOnLegislations < ActiveRecord::Migration
  def up
    change_column :legislations, :bill_title, :text
  end

  def down
    change_column :legislations, :bill_title, :string
  end
end
