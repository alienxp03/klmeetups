# == Schema Information
#
# Table name: oauths
#
#  id           :integer          not null, primary key
#  access_token :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Oauth, type: :model do
  subject { create(:oauth) }

  it { should be_valid }
  it { should validate_presence_of(:access_token) }
end
