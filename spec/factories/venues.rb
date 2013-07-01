# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    address "MyString"
    zipcode 1
    city "MyString"
    state "MyString"
  end
end
