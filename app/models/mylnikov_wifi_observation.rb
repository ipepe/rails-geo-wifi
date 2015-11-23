class MylnikovWifiObservation < WifiObservation

  def self.import_csv
    csv_file = File.open(Rails.root.join('db', 'wifis', 'mylnikov_org', 'small_wifi.csv'))
    # 'id' bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    # 'bssid' varchar(12) NOT NULL,
    # 'signal' smallint(6) NOT NULL DEFAULT '-200',
    # 'lon' decimal(13,8) NOT NULL,
    # 'lat' decimal(13,8) NOT NULL,
    # 'updated' int(11) NOT NULL DEFAULT '1428513555',
    # 'created' int(11) NOT NULL DEFAULT '1428513555',
    # 'data' tinyint(4) NOT NULL DEFAULT '0',
    # 'range' decimal(6,2) NOT NULL DEFAULT '140.00',

    i = 0
    SmarterCSV.process(csv_file, {
                                   :chunk_size => 100,
                                   col_sep: ",",
                                   headers_in_file: false,
                                   user_provided_headers: [:id, :bssid, :signal, :lon, :lat, :updated, :created, :data, :range]
                               }) do |chunk|
      self.transaction do
        chunk.each do |row|
          if (49..55).include?(row[:lat].to_i) && (14..24).include?(row[:lon].to_i)
            self.create!(bssid: row[:bssid], longitude: row[:lon], latitude: row[:lat], raw_info_json: row.to_json)
          end
        end
      end
    end
  end
end