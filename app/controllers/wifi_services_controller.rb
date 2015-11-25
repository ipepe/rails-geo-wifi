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
    @heatmap_grouping_points = HeatmapGroupingPoint.warsaw_area.limit(7000)
    @heatmap_grouping_points_array = Rails.cache.fetch("wifi_services_controller/@heatmap_grouping_points_array", expires_in: 1.hours) do
      @heatmap_grouping_points.to_a
    end

    @heatmap_grouping_points_data = Rails.cache.fetch("wifi_services_controller/@heatmap_grouping_points_data", expires_in: 1.hours) do
      @heatmap_grouping_points_array.map(&:heat_data)
    end
    @heatmap_grouping_points_max_count = @heatmap_grouping_points_array.map(&:count).max*2/3

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
