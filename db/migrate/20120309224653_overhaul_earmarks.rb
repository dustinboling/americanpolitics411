class OverhaulEarmarks < ActiveRecord::Migration
  def change
    remove_column :earmarks, :description
    remove_column :earmarks, :sector
    remove_column :earmarks, :amount
    remove_column :earmarks, :year
    
    add_column :earmarks, :csv_earmark_id, :integer
    add_column :earmarks, :import_reference_id, :integer
    add_column :earmarks, :fiscal_year, :string
    add_column :earmarks, :budget_amount, :string
    add_column :earmarks, :house_amount, :string
    add_column :earmarks, :senate_amount, :string
    add_column :earmarks, :omni_amount, :string
    add_column :earmarks, :final_amount, :string
    add_column :earmarks, :bill, :text
    add_column :earmarks, :bill_section, :text
    add_column :earmarks, :bill_subsection, :text
    add_column :earmarks, :description, :text
    add_column :earmarks, :notes, :text
    add_column :earmarks, :presidential, :string
    add_column :earmarks, :undisclosed, :string
    add_column :earmarks, :house_members, :string
    add_column :earmarks, :house_parties, :string
    add_column :earmarks, :house_states, :string
    add_column :earmarks, :house_districts, :string
    add_column :earmarks, :senate_members, :string
    add_column :earmarks, :senate_parties, :string
    add_column :earmarks, :senate_states, :string
  end
end
