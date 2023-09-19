class Partner::Application < ActiveRecord::Base
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::Application

  SCOPES = [:write, :update, :read, :delete, :ocpi_request, :ocpi_token_c]

  serialize :scopes

  validates_presence_of :name, :scopes

  before_validation :set_redirect_uri
  before_validation :set_default_environment

  after_create :add_to_members
  before_save  :remove_white_space

  has_many :access_grants, class_name: 'Partner::AccessGrant', foreign_key: :application_id, dependent: :destroy
  has_many :access_tokens, class_name: 'Partner::AccessToken', foreign_key: :application_id, dependent: :destroy
  has_many :api_request_logs, class_name: 'Partner::ApiRequestLog', foreign_key: :oauth_application_id, dependent: :destroy
  has_many :developer_partners
  has_many :partners, through: :developer_partners, dependent: :delete_all

  belongs_to :owner, optional: true, class_name: 'Partner::Partner', foreign_key: :owner_id

  scope :approved, -> { where(approved_by_admin: true) }
  scope :has_status_notification_webhook, -> { approved.where.not(status_notification_webhook: [nil, '']) }

  enum ocpi_validation_status: [:ocpi_pending, :ocpi_valid, :ocpi_invalid, :ocpi_connected]

  def remove_white_space
    custom_name = name.gsub!(/[^0-9A-Za-z]/, ' ') #remove all special char
    custom_name = name.split.each{|i| i.capitalize!}.join('') rescue 'Application'
    self.name   = custom_name
  end

  def set_default_environment
    self.environment = Rails.env
  end

  def set_redirect_uri
    self.redirect_uri = "urn:ietf:wg:oauth:2.0:oob" if redirect_uri.blank?
  end

  def add_to_members(member_id: nil)
    member_id = member_id.blank? ? owner_id : member_id
    Partner::DeveloperPartner.create(partner_id: member_id, application_id: self.id)
  end

  def has_member?(partner_id)
    partners.pluck(:id).include?(partner_id)
  end

  def is_ocpi?
    scopes.map(&:to_s).include?('ocpi_request') || scopes.map(&:to_s).include?('ocpi_token_c')
  end

  def generate_authorization
    ::Partner::AccessGrant.create(redirect_uri: redirect_uri, application_id: id, expires_in: 3600, resource_owner_id: owner.id, scopes: scopes)
  end

  def has_any_token?
    access_tokens.any?
  end

  def their_token
    return nil unless is_ocpi?
    acc_token = access_tokens.where.not(ocpi_credentials_id: nil).order(created_at: :desc).limit(1).last
    if acc_token
      acc_token.ocpi_credential.try(:token_b)
    end
  end

  def ocpi_reset!
    update(ocpi_validation_status: 'ocpi_pending', approved_by_admin: false)
  end
end

# == Schema Information
#
# Table name: oauth_applications
#
#  id                                 :bigint           not null, primary key
#  approved_by_admin                  :boolean          default(FALSE)
#  confidential                       :boolean          default(TRUE), not null
#  credentials_token_a                :string
#  environment                        :string           not null
#  name                               :string           not null
#  ocpi_validation_status             :integer          default("ocpi_pending")
#  ocpi_version_endpoint              :string
#  owner_type                         :string
#  payment_gateway_webhook            :string
#  payment_webhook_key                :string
#  payment_webhook_secret             :string
#  receive_push_model                 :boolean          default(TRUE)
#  redirect_uri                       :text
#  scopes                             :string           default(""), not null
#  secret                             :string           not null
#  status_notification_webhook        :string
#  status_notification_webhook_key    :string
#  status_notification_webhook_secret :string
#  uid                                :string           not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  owner_id                           :integer
#
# Indexes
#
#  index_oauth_applications_on_owner_id_and_owner_type  (owner_id,owner_type)
#  index_oauth_applications_on_uid                      (uid) UNIQUE
#
