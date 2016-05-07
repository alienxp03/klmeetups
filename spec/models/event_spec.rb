require 'rails_helper'

describe Event, type: :model do
  subject { create(:event) }

  it { should be_valid }
  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
end
