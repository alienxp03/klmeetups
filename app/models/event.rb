class Event < ActiveRecord::Base
  validates :external_id, uniqueness: true

  belongs_to :group
  belongs_to :location
  accepts_nested_attributes_for :location

  scope :latest, -> { all }

  def self.updated?
    BaseApi.create(last_updated: 1.month.ago) if BaseApi.count == 0

    if count == 0 || (Time.current - BaseApi.last.last_updated) >= 1.hour / 2
      return false
    end
    true
  end
end
