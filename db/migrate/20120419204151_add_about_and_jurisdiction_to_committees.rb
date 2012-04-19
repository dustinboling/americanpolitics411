class AddAboutAndJurisdictionToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :about, :text
    add_column :committees, :jurisdiction, :text
  end
end
