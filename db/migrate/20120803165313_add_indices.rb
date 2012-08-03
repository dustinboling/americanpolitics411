class AddIndices < ActiveRecord::Migration
  def change
    add_index :people, :bioguide_id
    add_index :people, :state_represented
    add_index :people, :slug
    add_index :people, :govtrack_id
    add_index :people, :crp_id
    add_index :people, :nyt_id
    add_index :people, :current_party
    add_index :people, :last_name
    add_index :legislations, :congress_year
    add_index :legislations, :bill_number
    add_index :legislations, :introduced_year
    add_index :issues, :name
  end
end
