class AddFieldsToPersonVotes < ActiveRecord::Migration
  def change
    add_column :person_votes, :voted_at, :timestamp
    add_column :person_votes, :how, :string
    add_column :person_votes, :result, :string
  end
end
