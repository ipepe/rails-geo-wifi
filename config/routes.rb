Rails.application.routes.draw do

  resources :geolocation, only: [] do
    collection do
      get "geocode"
      get "reverse_geocode"
      get "current_location"
    end
  end

  resources :wifi_services, only: [:index]
  root 'wifi_services#heatmap'
end
