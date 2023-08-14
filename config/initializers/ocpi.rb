# frozen_string_literal: true

OcpiConfiguration.setup do |config|
  # Configure the base url
  config.scheme = Rails.application.credentials.ocpi[:scheme]
  config.base_url = Rails.application.credentials.ocpi[:base_url]
  config.base_path = '/ocpi/'

  # Debug grape endpoint
  config.debug = true

  # API Doc setting
  config.api_doc.http_auth = true
  config.api_doc.username = 'ocpi'
  config.api_doc.password = 'ocpi'

  # OCPI Version
  config.market_roles = %w[CPO EMSP]
  config.enabled_modules.emsp = %w[locations tokens sessions tariffs commands cdrs]
  config.enabled_modules.cpo = %w[locations tokens sessions tariffs commands cdrs]

  # Logger
  config.logger.enable = false
  config.logger.type = 'sidekiq'
end
