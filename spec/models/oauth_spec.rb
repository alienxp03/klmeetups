require 'rails_helper'

describe Oauth, type: :model do
  subject { create(:oauth) }

  it { should be_valid }
  it { should validate_presence_of(:access_token) }
end
