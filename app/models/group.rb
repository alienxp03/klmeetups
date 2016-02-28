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

class Group < ActiveRecord::Base
  validates :external_id, :name, :url, presence: true
end
