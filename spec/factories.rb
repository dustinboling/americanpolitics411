FactoryGirl.define do
  factory :person do
    first_name Faker::Name.first_name
    middle_name Faker::Name.first_name
    last_name Faker::Name.last_name
    bio "This is a test bio"
    professional_experience "This is some test professional experience"
    literary_work "This is some test literary work"
    photo_url "http://www.govtrack.us/data/photos/400221-200px.jpeg"
    current_party "D"
    state_represented "CA"
    district "1"
    birthplace "Orange, CA"
    date_of_birth "1947-07-05"
    religion_id 7
    twitter_id "ToddAkin"
    is_congress_member true
    chamber "H"
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
