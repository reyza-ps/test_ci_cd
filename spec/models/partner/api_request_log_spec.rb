require 'rails_helper'

RSpec.describe Partner::ApiRequestLog, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:oauth_application).optional }
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

  describe '.by_applications' do
    subject(:by_applications) { described_class.by_applications([oauth_application.id]) }
    let!(:api_request_log) { create :api_request_log, oauth_application:, request_type: 'incoming' }

    it 'returns by applications' do
      expect(by_applications).to contain_exactly(api_request_log)
    end
  end
end
