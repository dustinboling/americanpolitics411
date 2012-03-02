class CreateSubcommittees < ActiveRecord::Migration
  def change
    create_table :subcommittees do |t|
      t.integer :committee_id
      t.string :name
      t.string :code
      t.string :chamber

      t.timestamps
    end
  end
end
