namespace :wifis do

  task import_mylnikov: :environment do
    start_time = Time.now
    puts "Started mylnikov import at #{start_time}"
    MylnikovWifiObservation.import_csv
    end_time = Time.now
    puts "Time elapsed = #{end_time-start_time}s"
  end

  task import_openwlan: :environment do
    start_time = Time.now
    puts "Started openwlan import at #{start_time}"
    OpenWlanMapWifiObservation.import_csv
    end_time = Time.now
    puts "Time elapsed = #{end_time-start_time}s"
  end

  task import_radiocells: :environment do
    start_time = Time.now
    puts "Started radiocells import at #{start_time}"
    RadioCellsWifiObservation.import_csv
    end_time = Time.now
    puts "Time elapsed = #{end_time-start_time}s"
  end

  task import_all: [:import_mylnikov, :import_openwlan, :import_radiocells]
end