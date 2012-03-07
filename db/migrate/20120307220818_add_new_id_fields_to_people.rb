class AddNewIdFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :fec_id, :string
    add_column :people, :crp_id, :string
    add_column :people, :votesmart_id, :string
  end
end
