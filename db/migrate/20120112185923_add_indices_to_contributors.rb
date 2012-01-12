class AddIndicesToContributors < ActiveRecord::Migration
  def change
    add_index :contributors, :person_id
    add_index :contributors, :organization_id
  end
end
