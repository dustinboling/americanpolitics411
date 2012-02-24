class AddCongressYearToLegislations < ActiveRecord::Migration
  def change
    add_column :legislations, :congress_year, :string
  end
end
