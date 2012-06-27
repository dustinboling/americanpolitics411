class AddIntroducedYearToLegislation < ActiveRecord::Migration
  def change
    add_column :legislations, :introduced_year, :integer
  end
end
