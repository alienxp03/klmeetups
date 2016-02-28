# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  external_id      :string
#  url              :string
#  name             :string
#  description      :string
#  start_time       :datetime
#  end_time         :datetime
#  attending_count  :string
#  interested_count :string
#  last_updated     :datetime
#  group_id         :integer
#  location_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Event < ActiveRecord::Base
  validates_uniqueness_of :external_id, case_sensitive: true
  validates :name, :url, :external_id, presence: true

  belongs_to :group
  belongs_to :location
  accepts_nested_attributes_for :group
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
