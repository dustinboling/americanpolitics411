Factory.define :person do |f|
  f.first_name Faker::Name.first_name
  f.middle_name Faker::Name.first_name
  f.last_name Faker::Name.last_name
  f.contact_street_address Faker::Address.street_address(include_secondary = false)
  f.contact_city Faker::Address.city
  f.contact_zip Faker::Address.zip
  f.contact_state Faker::Address.state
  f.bio "This is a test bio"
  f.professional_experience "This is some test professional experience"
  f.literary_work "This is some test literary work"
end

## roles_mask
# admin = 1
# superadmin = 2
# reader = 4?
Factory.define :user do |f|
  f.sequence(:username) {|n| "test-account#{n}"}
  f.sequence(:email) {|n| "test-account-#{n}@dustinboling.com"}
  f.password '123'
  f.password_confirmation '123'
end
