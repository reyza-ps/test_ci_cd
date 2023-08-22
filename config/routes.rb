Rails.application.routes.draw do
  resources :connectors, only: [:index, :show]
  resources :evses, only: [:index, :show]
  resources :locations, only: [:index, :show]
  get 'locations/show'
  mount Ocpi::Engine => '/'
  get '/' => 'home#index'
  get '/table' => 'home#table'
  root to: "home#index"
  devise_for :users
  # Admin routes
  namespace :admin do
    resources :partners
  end
  
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
  end
  
  namespace :partner do
    root 'dashboard#index'
  end
end
