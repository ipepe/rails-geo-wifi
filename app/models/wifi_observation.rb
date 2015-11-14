class WifiObservation < ActiveRecord::Base

  belongs_to :wifi_service
  belongs_to :wifi_name
  validates_presence_of :wifi_service, :latitude, :longitude, :raw_info_json

  reverse_geocoded_by :latitude, :longitude

  after_create do
    service = self.wifi_service
    service.recalculate_position
    service.save
  end

  def bssid=(value)
    value = WifiService.standardize_bssid(value)
    self.wifi_service = WifiService.find_or_create_by(bssid: value)
    self.wifi_service.bssid
  end

  def bssid
    self.wifi_service.bssid
  end

  def ssid=(value)
    self.wifi_name = WifiName.find_or_create_by(ssid: value)
    self.wifi_name.ssid
  end

  def ssid
    self.wifi_name.ssid
  end

  def initialize(*args)
    raise "Cannot directly instantiate a #{self.class}" if self.class == WifiObservation
    super
  end
end
