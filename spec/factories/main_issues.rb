# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :main_issue, :class => 'MainIssues' do
    name "MyString"
  end
end
