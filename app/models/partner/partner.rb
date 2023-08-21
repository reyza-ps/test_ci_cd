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
end
