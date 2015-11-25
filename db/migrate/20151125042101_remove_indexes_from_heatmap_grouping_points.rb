class RemoveIndexesFromHeatmapGroupingPoints < ActiveRecord::Migration
  def change
    remove_index :heatmap_grouping_points, :latitude
    add_index :heatmap_grouping_points, :latitude, unique: false

    remove_index :heatmap_grouping_points, :longitude
    add_index :heatmap_grouping_points, :longitude, unique: false
  end
end
