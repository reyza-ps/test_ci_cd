class Partner::AccessToken < ActiveRecord::Base
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessToken

  belongs_to :access_grant, class_name: 'Partner::AccessGrant', foreign_key: :oauth_access_grant_id, optional: true

  belongs_to :ocpi_credential, class_name: '::Ocpi::Domain::Credentials::Models::Credential', optional: true, foreign_key: :ocpi_credentials_id

  class << self
    def create_relations(access_grant_token:, access_token:)
      acc_grant = ::Partner::AccessGrant.find_by_token(access_grant_token)
      acc_token = ::Partner::AccessToken.find_by_token(access_token)
      acc_token.update(oauth_access_grant_id: acc_grant.id) unless acc_grant.blank? && acc_token.blank?
      acc_token
    end

    def update_to_token_c(access_token:, ocpi_credential:)
      acc_token = ::Partner::AccessToken.find_by_token(access_token.token)
      application = acc_token.application
      Partner::AccessToken.transaction do
        acc_token.update(token: ocpi_credential.token, ocpi_credentials_id: ocpi_credential.id,scopes: ['ocpi_token_c'])
        application.update(ocpi_validation_status: :ocpi_connected)
      end
      acc_token
    end

    def reset_ocpi_config!(current_access_token:)
      Partner::AccessToken.transaction do
        application = current_access_token.application
        current_access_token.destroy
        application.ocpi_reset!
      end
    end
  end
end

# == Schema Information
#
# Table name: oauth_access_tokens
#
#  id                     :bigint           not null, primary key
#  expires_in             :integer
#  previous_refresh_token :string           default(""), not null
#  refresh_token          :string
#  revoked_at             :datetime
#  scopes                 :string
#  token                  :string           not null
#  created_at             :datetime         not null
#  application_id         :bigint           not null
#  oauth_access_grant_id  :bigint
#  ocpi_credentials_id    :string
#  resource_owner_id      :bigint
#
# Indexes
#
#  index_oauth_access_tokens_on_application_id         (application_id)
#  index_oauth_access_tokens_on_oauth_access_grant_id  (oauth_access_grant_id)
#  index_oauth_access_tokens_on_refresh_token          (refresh_token) UNIQUE
#  index_oauth_access_tokens_on_resource_owner_id      (resource_owner_id)
#  index_oauth_access_tokens_on_token                  (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (application_id => oauth_applications.id)
#  fk_rails_...  (resource_owner_id => partners.id)
#
