Rails.application.routes.draw do
  resources :locations
  get 'locations/show'
  get '/' => 'home#index'
  get '/table' => 'home#table'
  root to: "home#index"
  devise_for :users

  mount Ocpi::Engine => '/'
end
