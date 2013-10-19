FactoryGirl.define do
  factory :organization do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "foobar"
  end
end