# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  latitude   :float
#  longitude  :float
#  street     :string
#  zip        :string
#  city       :string
#  state      :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :location do
    name        { FFaker::Lorem.word }
    latitude    { FFaker::Geolocation.lat }
    longitude   { FFaker::Geolocation.lng }
    street      { FFaker::AddressUS.street_name }
    zip         { FFaker::AddressUS.zip_code }
    city        { FFaker::AddressUS.city }
    state       { FFaker::AddressUS.state }
    country     { FFaker::AddressUS.country }
  end
end
