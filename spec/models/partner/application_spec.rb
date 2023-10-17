require 'rails_helper'

RSpec.describe Partner::Application, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:owner).optional }
    it { is_expected.to have_many(:api_request_logs) }
    it { is_expected.to have_many(:access_grants) }
    it { is_expected.to have_many(:access_tokens) }
    it { is_expected.to have_many(:developer_partners) }
    it { is_expected.to have_many(:partners) }
  end

  let(:partner) { create :partner }

  describe 'has_member?' do
    let(:oauth_application) do
      create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner', approved_by_admin: true,
                                 name: 'razer'
    end

    it 'return true' do
      oauth_application
      expect(oauth_application.has_member?(partner.id)).to eq true
    end
  end

  describe 'is_ocpi?' do
    let(:oauth_application) do
      create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner', approved_by_admin: true,
                                 name: 'razer', scopes: ['ocpi_request']
    end

    it 'return true' do
      oauth_application
      expect(oauth_application.is_ocpi?).to eq true
    end
  end

  describe 'has_any_token?' do
    let(:oauth_application) do
      create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner', approved_by_admin: true,
                                 name: 'razer', scopes: ['ocpi_request']
    end
    let(:access_grant) do
      create :oauth_access_grant, redirect_uri: oauth_application.redirect_uri, application_id: oauth_application.id,
                                  expires_in: 3600, resource_owner_id: oauth_application.owner.id,
                                  scopes: oauth_application.scopes
    end
    let(:oauth_access_token) do
      create :oauth_access_token, application_id: oauth_application.id, resource_owner_id: partner.id,
                                  oauth_access_grant_id: access_grant.id
    end

    it 'return true' do
      oauth_access_token
      expect(oauth_application.has_any_token?).to eq true
    end
  end

  describe 'their_token' do
    let(:oauth_application) do
      create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner',
                                 approved_by_admin: true, name: 'razer', scopes: ['ocpi_request']
    end
    let(:ocpi_credential) { create :ocpi_credential }
    let(:access_grant) do
      create :oauth_access_grant, redirect_uri: oauth_application.redirect_uri, application_id: oauth_application.id,
                                  expires_in: 3600, resource_owner_id: oauth_application.owner.id,
                                  scopes: oauth_application.scopes
    end
    let(:oauth_access_token) do
      create :oauth_access_token, application_id: oauth_application.id, resource_owner_id: partner.id,
                                  oauth_access_grant_id: access_grant.id, ocpi_credentials_id: ocpi_credential.id
    end

    it 'return their token' do
      oauth_access_token
      expect(oauth_application.their_token.present?).to eq true
    end
  end

  describe 'ocpi_reset!' do
    let(:oauth_application) do
      create :oauth_application, owner_id: partner.id, owner_type: 'Partner::Partner',
                                 approved_by_admin: true, name: 'razer', scopes: ['ocpi_request'],
                                 ocpi_validation_status: 'ocpi_connected'
    end
    it 'update ocpi_validation_status to ocpi_pending' do
      oauth_application.ocpi_reset!
      expect(oauth_application.ocpi_validation_status).to eq 'ocpi_pending'
    end
  end
end
