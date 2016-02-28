# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  external_id      :string
#  url              :string
#  name             :string
#  description      :string
#  start_time       :datetime
#  end_time         :datetime
#  attending_count  :string
#  interested_count :string
#  last_updated     :datetime
#  group_id         :integer
#  location_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  sequence(:event_time) { |n| Time.current + n.hour }

  factory :event do
    sequence(:external_id) { |n| "external_id#{n}" }
    name              { FFaker::Lorem.word }
    url               { FFaker::Internet.http_url }
    description       { FFaker::Lorem.sentence }
    start_time        { FactoryGirl.generate(:event_time) }
    end_time          { FactoryGirl.generate(:event_time) }
    attending_count   30
    interested_count  50
    last_updated      30.minutes.ago
    location
  end
end
