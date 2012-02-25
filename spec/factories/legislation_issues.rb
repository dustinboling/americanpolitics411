# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :legislation_issue do
    legislation_id 1
    issue_id 1
    year "MyString"
  end
end
