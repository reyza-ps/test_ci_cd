class Partner::Partner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :logo, CoverImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :address, :city, :name, presence: true

  has_many :oauth_applications, class_name: 'Partner::Application', as: :owner
  has_many :access_grants, class_name: 'Partner::AccessGrant', foreign_key: :resource_owner_id, dependent: :delete_all
  has_many :access_tokens, class_name: 'Partner::AccessToken', foreign_key: :resource_owner_id, dependent: :delete_all
  has_many :developer_partners
  has_many :applications, through: :developer_partners, dependent: :delete_all

  belongs_to :user, optional: true

  before_validation :generate_required_field, on: :create

  def is_owner?(application_id = nil)
    application = ::Partner::Application.find_by_id(application_id)
    application.try(:owner).try(:id).eql?(id)
  end

  private

  def generate_required_field
    self.code = uniq_id
    self.registration_no = "EVC-P#{uniq_id}"
  end

  def uniq_id
    id = DateTime.now.strftime('%Y%m%d%H%M%S%L')
    id = id.to_i.to_s(36)
    id.upcase
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[address charger_group_option city code confirmation_sent_at confirmation_token confirmed_at
       country country_code created_at email encrypted_password id logo mobile_phone name ocpi_percentage_fee overview party_id postcode registration_no remember_created_at reset_password_sent_at reset_password_token state unconfirmed_email updated_at user_id website_url]
  end
end
