class ChangeNetWorthFieldsOnPeople < ActiveRecord::Migration
  def up
    change_column :people, :net_worth_minimum, :string
    change_column :people, :net_worth_average, :string
    change_column :people, :net_worth_maximum, :string
  end

  def down
    change_column :people, :net_worth_minimum, :integer
    change_column :people, :net_worth_average, :integer
    change_column :people, :net_worth_maximum, :integer
  end
end
