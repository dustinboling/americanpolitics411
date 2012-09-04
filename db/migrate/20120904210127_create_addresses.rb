class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :person_id
      t.string :title
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :twitter_id
      t.string :phone
      t.string :fax
      t.string :email
      t.string :web_page_name
      t.string :web_url

      t.timestamps
    end
  end
end
