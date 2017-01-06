class Location < ActiveRecord::Base
  has_one :event

  validates :name, :latitude, :longitude, presence: true

  def formatted_address
    [name, city.try(:titleize)].join(', ')
  end
end
