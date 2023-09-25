class BroadcastClientInfo
  include Sidekiq::Job

  def perform(endpoint, status, cpo_party_id, cpo_country_code, role = 'EMSP')
    Ocpi::Domain::HubClientInfo::Services::SyncHubClientInfo.new(
      endpoint, status, cpo_party_id, cpo_country_code, role
    ).sync
  end
end
