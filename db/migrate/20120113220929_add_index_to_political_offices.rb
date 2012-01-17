class AddIndexToPoliticalOffices < ActiveRecord::Migration
  def change
    add_index :political_offices, :person_id
  end
end
