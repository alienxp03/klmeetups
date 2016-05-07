FactoryGirl.define do
  factory :group do
    sequence(:external_id) { |n| n }
    url                 { FFaker::Internet.http_url }
    name                { FFaker::Lorem.word }
    status              { Event.statuses[:authorized] }
  end
end
