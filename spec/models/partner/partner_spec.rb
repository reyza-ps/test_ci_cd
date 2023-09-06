require 'rails_helper'

RSpec.describe Partner::Partner, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:oauth_applications) }
    it { is_expected.to have_many(:access_grants) }
    it { is_expected.to have_many(:access_tokens) }
    it { is_expected.to have_many(:developer_partners) }
    it { is_expected.to have_many(:applications) }
  end
end
