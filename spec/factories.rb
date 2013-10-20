FactoryGirl.define do

  factory :organization do
    email {"user_#{rand(1000).to_s}@factory.com" }
    password "password"
  end

  factory :team do
    name {"foo_#{rand(9000).to_s}" }
  end

end