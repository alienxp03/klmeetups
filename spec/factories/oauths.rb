# == Schema Information
#
# Table name: oauths
#
#  id           :integer          not null, primary key
#  access_token :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :oauth do
    access_token 'random_token'
  end
end
