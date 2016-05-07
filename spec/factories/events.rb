FactoryGirl.define do
  factory :event do
    sequence(:external_id) { |n| "external_id#{n}" }
    name              { FFaker::Lorem.word }
    url               { FFaker::Internet.http_url }
    status            { Event.statuses[:authorized] }
    entry_type        { Event.entry_types[:automated] }
    description       { FFaker::Lorem.sentence }
    start_time        { 3.days.from_now }
    end_time          { 3.days.from_now + 1.hour }
    location
    group
  end
end
