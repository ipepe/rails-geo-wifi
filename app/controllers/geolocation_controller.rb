class GeolocationController < ApplicationController

  def geocode
    result = nil
    if params[:address].present?
      result = geocode_to_result(Geocoder.search(params[:address].to_s).first)
    end
    send_data({result: result}.to_json, type: "application/json", disposition: 'inline')
  end

  def reverse_geocode
    result = nil
    if params[:latitude].present? && params[:longitude].present?
      result = geocode_to_result(Geocoder.search([params[:latitude].to_f, params[:longitude].to_f]).first)
    end
    send_data({result: result}.to_json, type: "application/json", disposition: 'inline')
  end

  def current_location
    result = geocode_to_result(current_user_location)
    send_data({result: result}.to_json, type: "application/json", disposition: 'inline')
  end

  private
  def geocode_to_result(g=nil)
    {address: g.address, coordinates: g.coordinates} if g.present? && g.try(:class).to_s.include?("Geocoder::Result")
  end
end