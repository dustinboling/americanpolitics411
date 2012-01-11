class AddIndexToEndorsements < ActiveRecord::Migration
  def change
    add_index :endorsements, :person_id
  end
end
