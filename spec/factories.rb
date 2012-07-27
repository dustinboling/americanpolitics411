FactoryGirl.define do
  factory :person do
    first_name Faker::Name.first_name
    middle_name Faker::Name.first_name
    last_name Faker::Name.last_name
    contact_street_address Faker::Address.street_address(include_secondary = false)
    contact_city Faker::Address.city
    contact_zip Faker::Address.zip
    contact_state Faker::Address.state
    bio "This is a test bio"
    professional_experience "This is some test professional experience"
    literary_work "This is some test literary work"
  end

  ## roles_mask
  # admin = 1
  # superadmin = 2
  # reader = 4?
  factory :user do
    sequence(:username) {|n| "test-account#{n}"}
    sequence(:email) {|n| "test-account-#{n}@dustinboling.com"}
    password '123'
    password_confirmation '123'
  end

  factory :religion do
    id 7
    name "Anti-Alanism"
  end
end
