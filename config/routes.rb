Rails.application.routes.draw do
  resources :connectors, only: [:index, :show]
  resources :evses, only: [:index, :show]
  resources :locations, only: [:index, :show]
  get 'locations/show'
  get '/' => 'home#index'
  get '/table' => 'home#table'
  root to: "home#index"
  devise_for :users

  mount Ocpi::Engine => '/'
end
