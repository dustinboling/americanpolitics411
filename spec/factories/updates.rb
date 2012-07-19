# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    task "MyString"
    utc_timestamp "2012-07-19 14:02:54"
  end
end
