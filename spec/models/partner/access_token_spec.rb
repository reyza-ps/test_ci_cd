require 'rails_helper'

RSpec.describe Partner::AccessToken, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:access_grant).optional }
    it { is_expected.to belong_to(:ocpi_credential).optional }
  end

  let(:partner) { create :partner }
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

  describe 'create_relations' do
    it 'return access_token relation' do
      oauth_access_token
      described_class.create_relations(access_grant_token: access_grant, access_token: oauth_access_token)

      expect(oauth_access_token.oauth_access_grant_id).to eq access_grant.id
    end
  end

  describe 'update_to_token_c' do
    it 'return access_token relation' do
      oauth_access_token
      described_class.update_to_token_c(access_token: oauth_access_token, ocpi_credential:)

      expect(oauth_application.reload.ocpi_validation_status).to eq 'ocpi_connected'
    end
  end

  describe 'reset_ocpi_config!' do
    it 'return access_token relation' do
      oauth_access_token
      described_class.reset_ocpi_config!(current_access_token: oauth_access_token)

      expect(oauth_application.reload.ocpi_validation_status).to eq 'ocpi_pending'
    end
  end
end
