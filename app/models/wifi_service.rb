class WifiService < ActiveRecord::Base

  has_many :wifi_names, through: :wifi_observations
  has_many :wifi_observations
  validates_presence_of :bssid, :wifi_observations#, :latitude, :longitude

  def bssid=(value)
    super(WifiService.standardize_bssid(value))
  end

  def display_name
    if self.ssids.first.present?
      "#{self.ssids.first} (#{self.delimetered_bssid})"
    else
      self.delimetered_bssid
    end
  end

  def recalculate_position
    observations = self.wifi_observations.to_a
    self.latitude = observations.map(&:latitude).sum / observations.size
    self.longitude = observations.map(&:longitude).sum / observations.size
  end

  def ssids
    self.wifi_names.map(&:ssid)
  end

  def geojson_coordinates
    [self.longitude, self.latitude]
  end

  def delimetered_bssid
    self.bssid.to_s.scan(/.{2}/).join(":")
  end

  def self.standardize_bssid(value)
    #00:0A:E6:3E:FD:E1
    value = value.to_s.upcase.gsub(/[^A-F0-9]/, '')
    value = nil if value.size != 12
    value
  end

end
