class RemovePersonIdDegreeIdFromUniversities < ActiveRecord::Migration
  def up
    remove_column :universities, :person_id
    remove_column :universities, :degree_id
  end

  def down
    add_column :universities, :person_id, :integer
    add_column :universities, :degree_id, :integer
  end
end