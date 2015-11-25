class AddCountToHeatmapGroupingPoint < ActiveRecord::Migration
  def change
    change_table :heatmap_grouping_points do |t|
      t.integer :count
    end
  end
end
