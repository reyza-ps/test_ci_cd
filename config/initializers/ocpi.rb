# frozen_string_literal: true

OcpiConfiguration.setup do |config|
  # Configure the base url
  config.scheme = ENV['OCPI_SCHEME']
  config.base_url = ENV['OCPI_BASE_URL']
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
  config.enabled_modules.cpo = %w[locations tokens sessions tariffs commands cdrs hubclientinfo]
  config.credentials.callbacks.register = 'OcpiWorker::MappingParty'

  # Logger
  config.logger.enable = true
  config.logger.type = 'sidekiq'
  config.hub.broadcast_client_info = 'BroadcastClientInfo'
  config.logger.incoming = 'OcpiApiRequestLogJob'
  config.logger.outgoing = 'OcpiApiRequestLogJob'

  # config.partner = 'Partner::Partner'
end
