# == Schema Information
#
# Table name: base_apis
#
#  id           :integer          not null, primary key
#  last_updated :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe BaseApi do
  subject { create(:base_api) }

  it { should be_valid }

  context 'create more than one' do
    let!(:base_api) { create(:base_api) }
    let!(:invalid_base_api) { build(:base_api) }

    it 'should fail' do
      expect(invalid_base_api).to_not be_valid
    end
  end
end
