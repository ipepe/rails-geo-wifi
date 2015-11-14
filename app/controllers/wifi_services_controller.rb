class WifiServicesController < ApplicationController

  def index
    @wifi_services = WifiService.all.includes(:wifi_observations).limit(3000)
    gon.wifi_services_geojson = JSON.parse(render_to_string(template: 'wifi_services/index.json.jbuilder', locals: { wifi_services: @wifi_services}))
    @wifi_services
    render :index, formats: :html
  end
end
