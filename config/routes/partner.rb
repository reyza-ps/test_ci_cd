devise_for :partners, class_name: 'Partner::Partner', controllers: {
  sessions:             'partner/devise/sessions',
  passwords:            'partner/devise/passwords',
  registrations:        'partner/devise/registrations',
  confirmations:        'partner/devise/confirmations',
  unlocks:              'partner/devise/unlocks'
}

use_doorkeeper scope: 'partner' do
  controllers applications: 'partner/oauth_applications'
  controllers authorizations: 'partner/authorizations'
  controllers tokens: 'partner/tokens'
  # skip_controllers :authorizations, :authorized_applications
end

namespace :api do
  namespace :partner do
    namespace :v1 do
      get  '/profile' => 'partners#profile'
      get  'charge_station/:serial_number/charging_session' => 'charge_stations#charging_session', as: 'charging_session'
      get  'charge_station/:serial_number/charging_session/histories' => 'charge_stations#charging_session_histories', as: 'charging_session_histories'
      get  'charge_station/:serial_number/charging_session/:session_id/invoice_info' => 'charge_stations#invoice_info', as: 'invoice_info'
      post 'charge_station/:serial_number/init_charging' => 'charge_stations#init_charging', as: 'init_charging'
      post 'charge_station/:serial_number/stop_charging' => 'charge_stations#stop_charging', as: 'stop_charging'
      post 'charge_station/:serial_number/init_charging_connector' => 'charge_stations#init_charging_connector', as: 'init_charging_connector'
      post 'charge_station/:serial_number/stop_charging_connector' => 'charge_stations#stop_charging_connector', as: 'stop_charging_connector'
      resources :locations, only: [:index, :show]
    end
  end
end

namespace :partner do
  root 'dashboard#index'

  get 'api/request/log/:arl_id/details' => 'dashboard#arl_details', as: :api_request_log_details
  resources :members, controller: 'members'

  post '/tokens/ocpi_request' => 'tokens#ocpi_request'
  post '/tokens/ocpi_connect' => 'tokens#ocpi_connect'
  delete '/tokens/ocpi_disconnect' => 'tokens#ocpi_disconnect'
  resources :ocpi_credentials
end