class AddYearToContributorsPacs < ActiveRecord::Migration
  def change
    add_column :contributors_pacs, :year, :date
  end
end
