class Partner::AccessGrant < ActiveRecord::Base
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessGrant

  has_one :access_token, class_name: 'Partner::AccessToken', foreign_key: :oauth_access_grant_id, dependent: :destroy
end

# == Schema Information
#
# Table name: oauth_access_grants
#
#  id                :bigint           not null, primary key
#  expires_in        :integer          not null
#  redirect_uri      :text             not null
#  revoked_at        :datetime
#  scopes            :string           default(""), not null
#  token             :string           not null
#  created_at        :datetime         not null
#  application_id    :bigint           not null
#  resource_owner_id :bigint           not null
#
# Indexes
#
#  index_oauth_access_grants_on_application_id     (application_id)
#  index_oauth_access_grants_on_resource_owner_id  (resource_owner_id)
#  index_oauth_access_grants_on_token              (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (application_id => oauth_applications.id)
#  fk_rails_...  (resource_owner_id => partners.id)
#
