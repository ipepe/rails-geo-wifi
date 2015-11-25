Rufus::Scheduler.new.every '1m' do
  puts "scheduler start"
  WifiService.transaction do
    WifiService.where(heatmap_grouping_point_id: nil).limit(100).each do |service|
      service.assign_heatmap_group
      service.save!
      service.heatmap_grouping_point.update_count
    end
  end
  puts "scheduler stop"
end