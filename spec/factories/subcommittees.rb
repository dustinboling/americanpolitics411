# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subcommittee do
    committee_id 1
    name "MyString"
    code "MyString"
    chamber "MyString"
  end
end
