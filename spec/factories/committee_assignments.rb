# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee_assignment do
    person_id 1
    committee_id 1
    year "MyString"
  end
end
