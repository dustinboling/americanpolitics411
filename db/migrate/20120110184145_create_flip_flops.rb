class CreateFlipFlops < ActiveRecord::Migration
  def change
    create_table :flip_flops do |t|
      t.integer :person_id
      t.date :year
      t.string :issue
      t.text :flipflop

      t.timestamps
    end
    add_index :flip_flops, :person_id
  end
end
