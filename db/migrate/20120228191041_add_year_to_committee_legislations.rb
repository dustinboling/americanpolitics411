class AddYearToCommitteeLegislations < ActiveRecord::Migration
  def change
    add_column :committee_legislations, :year, :string
  end
end
