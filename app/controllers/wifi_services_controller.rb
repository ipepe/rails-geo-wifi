class WifiServicesController < ApplicationController

  def marker_cluster
    @wifi_services = WifiService.warsaw_area.includes(:wifi_observations, :wifi_names).limit(1000)
    @wifi_services_json = @wifi_services.to_a.map(&:geojson_hash)
    gon.wifi_services_geojson = @wifi_services_json

    respond_to do |format|
      format.html { render :marker_cluster, formats: :html }
      format.json { render json: @wifi_services_json }
    end
  end

  def heatmap
    @wifi_services = WifiService.warsaw_area.includes(:wifi_observations, :wifi_names)
    @wifi_services_json = @wifi_services.to_a.map(&:geojson_hash)
    gon.wifi_services_geojson = @wifi_services_json

    respond_to do |format|
      format.html { render :heatmap, formats: :html }
      format.json { render json: @wifi_services_heatmap_data }
    end
  end
end
