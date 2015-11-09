class OpenWlanMapObservation < Observation

  def self.import_csv
    csv_file = File.open(Rails.root.join('db', 'wifis', 'openwlanmap_org', 'small_db.csv'))
    SmarterCSV.process(csv_file, {:chunk_size => 1000, col_sep: "\t"}) do |chunk|
      self.transaction do
        chunk.each do |row|
          self.create!(bssid: row[:bssid], longitude: row[:lon], latitude: row[:lat])
        end
      end
    end

    @csv
  end

end