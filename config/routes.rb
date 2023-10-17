Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :connectors, only: %i[index show]
  resources :evses, only: %i[index show]
  resources :locations, only: %i[index show]
  resources :credentials, only: %i[index show]
  resources :logs, only: %i[index show]
  resources :client_infos, only: [:index]
  get 'locations/show'
  mount Ocpi::Engine => '/'
  get '/' => 'home#index'
  get '/table' => 'home#table'
  root to: 'home#index'
  devise_for :users
  # Admin routes
  namespace :admin do
    resources :partners, controller: 'partner/partners', only: %i[index show edit update] do
      member do
        put '/push/', to: 'partner/partners#push_charger_group', as: :push_charger_group
        put '/download/', to: 'partner/partners#download_charger_group', as: :download_charger_group
      end

      resources :oauth_applications, controller: 'partner/oauth_applications', except: %i[index destroy] do
        member do
          get :approve
          get :validate
          post :receive_push
          get :ocpi_disconnect
          get :ocpi_modules
        end
      end
    end

    resources :admins
  end

  devise_for :partners, class_name: 'Partner::Partner', controllers: {
    sessions: 'partner/devise/sessions',
    passwords: 'partner/devise/passwords',
    registrations: 'partner/devise/registrations',
    confirmations: 'partner/devise/confirmations',
    unlocks: 'partner/devise/unlocks'
  }

  use_doorkeeper scope: 'partner' do
    controllers applications: 'partner/oauth_applications'
    controllers authorizations: 'partner/authorizations'
    controllers tokens: 'partner/tokens'
  end

  namespace :partner do
    root 'dashboard#index'
    post '/tokens/ocpi_request' => 'tokens#ocpi_request'
    post '/tokens/ocpi_connect' => 'tokens#ocpi_connect'
    delete '/tokens/ocpi_disconnect' => 'tokens#ocpi_disconnect'
  end
end
