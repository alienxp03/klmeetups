class BaseApi < ActiveRecord::Base
  validates :last_updated, presence: true
  validate :only_one, on: :create

  def only_one
    errors.add :base, 'Should only have one base api' unless BaseApi.count == 0
  end
end
