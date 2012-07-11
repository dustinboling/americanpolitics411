class AddBirthplaceToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birthplace, :string
  end
end
