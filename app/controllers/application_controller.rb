class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user_location

  def current_user_location
    @location ||= Rails.cache.fetch("current_user_location/#{request.geocoder_spoofable_ip}") do
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("Warszawa").first
      else
        @location ||= request.location
        @location ||= Geocoder.search("Warszawa").first
      end
      @location
    end
    gon.current_user_location_coordinates = @location.coordinates
    @location
  end
end
