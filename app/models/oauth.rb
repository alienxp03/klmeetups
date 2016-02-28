# == Schema Information
#
# Table name: oauths
#
#  id           :integer          not null, primary key
#  access_token :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Oauth < ActiveRecord::Base
  validates :access_token, presence: true
end
