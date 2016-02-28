# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  external_id :string
#  name        :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :group do
    sequence(:external_id) { |n| n }
    url                 { FFaker::Internet.http_url }
    name                { FFaker::Lorem.word }
  end
end
