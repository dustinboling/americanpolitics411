class AddStateRepresentedToPeople < ActiveRecord::Migration
  def change
    add_column :people, :state_represented, :string
  end
end
