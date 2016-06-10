FactoryGirl.define do
  factory :location do
    name        { FFaker::Lorem.word }
    latitude    { FFaker::Geolocation.lat }
    longitude   { FFaker::Geolocation.lng }
    full_address   { FFaker::Geolocation.street_name }
    street      { FFaker::AddressUS.street_name }
    zip         { FFaker::AddressUS.zip_code }
    city        { FFaker::AddressUS.city }
    state       { FFaker::AddressUS.state }
    country     { FFaker::AddressUS.country }
  end
end
