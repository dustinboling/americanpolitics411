Factory.define :person do |f|
  f.first_name Faker::Name.first_name
  f.last_name Faker::Name.last_name
  f.contact_street_address Faker::Address.street_address(include_secondary = false)
  f.contact_city Faker::Address.city
  f.contact_zip Faker::Address.zip
  f.contact_state Faker::Address.state
end

Factory.define :user do |f|
  f.username 'test_account'
  f.email 'testn@dustinboling.com'
  f.password '123'
  f.password_confirmation '123'
end

