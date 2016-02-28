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

require 'rails_helper'

  subject { create(:event) }

  it { should be_valid }
  it { should validate_uniqueness_of(:external_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
end

