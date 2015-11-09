class NetworkServicesController < ApplicationController

  def index
    @network_services = NetworkService.all
    gon.network_services_geojson = JSON.parse(render_to_string(template: 'network_services/index.json.jbuilder', locals: { network_services: @network_services}))
    @network_services
    render :index, formats: :html
  end
end
