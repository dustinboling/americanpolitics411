class AddRelationshipToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :relationship, :string
  end
end