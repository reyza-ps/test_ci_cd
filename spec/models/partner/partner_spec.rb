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

  describe 'is_owner?' do
    let(:partner) { create :partner }
    let(:oauth_application) { create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner', approved_by_admin: true, name: 'razer' }
    
    it 'return true' do
      oauth_application
      expect(partner.is_owner?(oauth_application.id)).to eq true
    end
  end
end
