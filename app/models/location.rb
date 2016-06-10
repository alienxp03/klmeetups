class Location < ActiveRecord::Base
  belongs_to :event

  validates :name, :latitude, :longitude, presence: true
end
