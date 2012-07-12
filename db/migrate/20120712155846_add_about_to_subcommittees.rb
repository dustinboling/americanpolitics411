class AddAboutToSubcommittees < ActiveRecord::Migration
  def change
    add_column :subcommittees, :about, :text
  end
end
