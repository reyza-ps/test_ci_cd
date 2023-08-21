class Partner::DeveloperPartner < ApplicationRecord
  belongs_to :partner
  belongs_to :application
end
