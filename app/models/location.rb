class Location < ActiveRecord::Base
  belongs_to :event

  validates :latitude, :longitude, presence: true
end
