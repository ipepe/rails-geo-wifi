start_time = Time.now
puts "Started import at #{start_time}"

MylnikovWifiObservation.import_csv
OpenWlanMapWifiObservation.import_csv
RadioCellsWifiObservation.import_csv

end_time = Time.now
puts "Time elapsed = #{end_time-start_time}s"