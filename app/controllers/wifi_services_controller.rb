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
    @heatmap_grouping_points = HeatmapGroupingPoint.warsaw_area.includes(:wifi_services).limit(5000)
    @heatmap_grouping_points_array = @heatmap_grouping_points.to_a
    @heatmap_grouping_points_data = @heatmap_grouping_points_array.map(&:heat_data)
    @heatmap_grouping_points_max_count = @heatmap_grouping_points_array.map(&:count).max

    respond_to do |format|
      format.html do
        gon.heatmap_grouping_points_max_count = @heatmap_grouping_points_max_count
        gon.heatmap_grouping_points_data = @heatmap_grouping_points_data

        render :heatmap, formats: :html
      end
      format.json { render json: { data: @heatmap_grouping_points_data, max: @heatmap_grouping_points_max_count}
      }
    end
  end
end
