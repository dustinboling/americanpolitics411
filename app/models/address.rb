class Address < ActiveRecord::Base
  attr_accessible :person_id, :title, :street_address, :city, :state, :zip_code, :phone, :fax

  belongs_to :person
end
