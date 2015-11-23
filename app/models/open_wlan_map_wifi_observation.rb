class OpenWlanMapWifiObservation < WifiObservation

  def self.import_csv
    csv_file = File.open(Rails.root.join('db', 'wifis', 'openwlanmap_org', 'small_db.csv'))
    SmarterCSV.process(csv_file, {:chunk_size => 1000, col_sep: "\t"}) do |chunk|
      self.transaction do
        chunk.each do |row|
          if (49..55).include?(row[:lat].to_i) && (14..24).include?(row[:lon].to_i)
            self.create!(bssid: row[:bssid], longitude: row[:lon], latitude: row[:lat], raw_info_json: row.to_json)
          end
        end
      end
    end

    @csv
  end

end