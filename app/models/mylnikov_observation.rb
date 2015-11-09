class MylnikovObservation < Observation

  def self.import_csv
    csv_file = File.open(Rails.root.join('db', 'wifis','mylnikov_org', 'small_wifi.csv'))
    @csv ||= CSV.parse(csv_file, headers: false)
    # 'id' bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    # 'bssid' varchar(12) NOT NULL,
    # 'signal' smallint(6) NOT NULL DEFAULT '-200',
    # 'lon' decimal(13,8) NOT NULL,
    # 'lat' decimal(13,8) NOT NULL,
    # 'updated' int(11) NOT NULL DEFAULT '1428513555',
    # 'created' int(11) NOT NULL DEFAULT '1428513555',
    # 'data' tinyint(4) NOT NULL DEFAULT '0',
    # 'range' decimal(6,2) NOT NULL DEFAULT '140.00',

    @csv.each do |row|
      MylnikovObservation.create!(bssid: row[1], longitude: row[3], latitude: row[4])
    end

    @csv
  end
end