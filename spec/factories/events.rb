FactoryGirl.define do
  sequence(:event_time) { |n| Time.current + n.hour }

  factory :event do
    sequence(:external_id) { |n| n }
    name              { FFaker::Lorem.word }
    description       { FFaker::Lorem.sentence }
    start_time        { FactoryGirl.generate(:event_time) }
    end_time          { FactoryGirl.generate(:event_time) }
    attending_count   30
    interested_count  50
    last_updated      30.minutes.ago
    location
  end
end
