class Location < ActiveRecord::Base
  belongs_to :event

  validates :name, :latitude, :longitude, presence: true

  def formatted_address
    [name, city.try(:titleize)].join(', ')
  end
end
