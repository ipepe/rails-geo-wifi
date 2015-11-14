class WifiServicesController < ApplicationController

  def index
    @wifi_services = WifiService.all.includes(:wifi_observations, :wifi_names).limit(1000)
    @wifi_services_json = @wifi_services.to_a.map(&:geojson_hash)
    gon.wifi_services_geojson = @wifi_services_json

    respond_to do |format|
      format.html { render :index, formats: :html }
      format.json { render json: @wifi_services_json }
    end
  end
end
