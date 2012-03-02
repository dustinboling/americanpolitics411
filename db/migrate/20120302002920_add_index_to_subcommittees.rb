class AddIndexToSubcommittees < ActiveRecord::Migration
  def change
    add_index :subcommittees, :committee_id
  end
end
