FactoryGirl.define do
  factory :admin do
    email       { FFaker::Internet.email }
    password    'password'
  end
end
