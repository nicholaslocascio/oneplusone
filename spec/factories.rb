FactoryGirl.define do

  factory :organization do
    email {"user_#{rand(10000000).to_s}@factory.com" }
    password "password"
  end

end