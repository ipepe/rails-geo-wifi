class CreateHeatmapGroupingPoints < ActiveRecord::Migration
  def change
    create_table :heatmap_grouping_points do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :heatmap_grouping_points, :latitude, unique: true
    add_index :heatmap_grouping_points, :longitude, unique: true

    change_table :wifi_services do |t|
      t.belongs_to :heatmap_grouping_point
    end

    add_index :wifi_services, :heatmap_grouping_point_id

  end
end
