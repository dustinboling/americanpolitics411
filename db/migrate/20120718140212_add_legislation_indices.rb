class AddLegislationIndices < ActiveRecord::Migration
  def up
    add_index :legislations, :introduced_date
    add_index :legislations, [:bill_type, :bill_number]
    add_index :legislations, :session
    add_index :legislations, :id
    add_index :legislations, :chamber
    add_index :legislations, :rtc_id
  end

  def down
  end
end
