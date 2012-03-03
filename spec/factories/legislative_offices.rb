# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :legislative_office do
    congress_year "MyString"
    chamber "MyString"
    state "MyString"
    district "MyString"
    party "MyString"
    seniority "MyString"
    start_date "MyString"
    end_date "MyString"
    bills_sponsored 1
    bills_cosponsored "MyString"
    missed_votes_pct "MyString"
    votes_with_party_pct "MyString"
  end
end
