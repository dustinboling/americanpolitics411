class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.string :name
      t.string :relationship
      t.text :notes

      t.timestamps
    end
  end
end
