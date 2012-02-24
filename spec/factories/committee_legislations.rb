# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee_legislation do
    committee_id 1
    legislation_id 1
    congress_year "MyString"
  end
end
