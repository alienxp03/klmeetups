class Oauth < ActiveRecord::Base
  validates :access_token, presence: true
end
