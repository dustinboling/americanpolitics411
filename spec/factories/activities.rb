# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user_id 1
    object "MyString"
    action "MyString"
  end
end
