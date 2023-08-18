Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/table' => 'home#table'
  root to: "home#index"
  devise_for :users

  mount Ocpi::Engine => '/'
end
