# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_vote, :class => 'PersonVotes' do
    person_id 1
    vote "MyText"
  end
end
