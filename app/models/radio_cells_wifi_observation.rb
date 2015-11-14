class RadioCellsWifiObservation < WifiObservation

  def self.import_csv
    csv_file = File.open(Rails.root.join('db', 'wifis', 'radiocells_org', 'small_wifis.csv'))
    SmarterCSV.process(csv_file, {:chunk_size => 1000, col_sep: ","}) do |chunk|
      self.transaction do
        chunk.each do |row|
          self.create!(bssid: row[:bssid], longitude: row[:lon], latitude: row[:lat], raw_info_json: row.to_json)
        end
      end
    end
  end

end