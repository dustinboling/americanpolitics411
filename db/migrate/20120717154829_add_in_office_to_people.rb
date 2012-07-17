class AddInOfficeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :in_office, :boolean
  end
end
