class WifiName < ActiveRecord::Base
  validates_presence_of :ssid
  has_many :wifi_observations
  has_many :wifi_services, through: :wifi_observations

  def bssids
    self.wifi_services.map(&:bssid)
  end
end
