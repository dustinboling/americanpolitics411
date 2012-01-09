class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people,  :current_residence, :string
    add_column :people, :dates_in_office, :text
    add_column :people, :photo_url, :string
    add_column :people, :contact_street_address, :string
    add_column :people, :contact_city, :string
    add_column :people, :contact_state, :string
    add_column :people, :contact_zip, :integer
    add_column :people, :contact_phone, :string
    add_column :people, :contact_fax, :string
    add_column :people, :contact_email, :string
    add_column :people, :contact_web_page_name, :string
    add_column :people, :contact_web_page_url, :string
    add_column :people, :net_worth_ranking, :integer
    add_column :people, :net_worth_minimum, :integer
    add_column :people, :net_worth_average, :integer
    add_column :people, :net_worth_maximum, :integer
    add_column :people, :family_members_id, :integer
  end
end