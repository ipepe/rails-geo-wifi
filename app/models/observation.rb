class Observation < ActiveRecord::Base

  belongs_to :network_service
  validates_presence_of :network_service, :latitude, :longitude

  def bssid=(value)
    value = NetworkService.standarize_bssid(value)
    self.network_service = NetworkService.find_or_create_by(bssid: value)
    self.network_service.bssid
  end

  def bssid
    self.network_service.bssid
  end

  def initialize(*args)
    raise "Cannot directly instantiate a #{self.class}" if self.class == Observation
    super
  end
end
