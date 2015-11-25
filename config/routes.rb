Rails.application.routes.draw do

  resources :geolocation, only: [] do
    collection do
      get "geocode"
      get "reverse_geocode"
      get "current_location"
    end
  end

  resources :wifi_services do
    collection do
      get 'heatmap'
      get 'marker_cluster'
    end
  end
end
