# == Schema Information
#
# Table name: base_apis
#
#  id           :integer          not null, primary key
#  last_updated :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :base_api do
    last_updated 2.hours.ago
  end
end
