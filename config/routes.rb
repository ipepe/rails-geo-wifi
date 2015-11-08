Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :geolocation, only: [] do
    collection do
      get "geocode"
      get "reverse_geocode"
      get "current_location"
    end
  end
  root 'geolocation#geocode'
end
