class NetworkService < ActiveRecord::Base

  belongs_to :network_name
  validates_presence_of :bssid

  def bssid=(value)
    value = NetworkService.standarize_bssid(value)
    super(value)
  end

  def ssid
    if self.network_name.present?
      self.network_name.ssid
    else
      self.delimetered_bssid
    end
  end

  def delimetered_bssid
    self.bssid.to_s.scan(/.{2}/).join(":")
  end

  def self.standarize_bssid(value)
    #00:0A:E6:3E:FD:E1
    value = value.to_s.upcase.gsub(/[^A-F0-9]/, '')
    value = nil if value.size != 12
    value
  end

end
