class HeatmapGroupingPoint < ActiveRecord::Base
  has_many :wifi_services
  validates_presence_of :latitude, :longitude

  after_initialize do
    self.update(count: self.count) if self.count != attributes['count'].to_i
  end

  def count
    Rails.cache.fetch("#{cache_key}/count") do
      self.wifi_services.size
    end
  end

  scope :warsaw_area, -> do
    where(latitude: (52.1..52.3), longitude: (20.8..21.2))
  end

  def heat_data
    [self.latitude, self.longitude, self.count]
  end

  validate on: :create do
    if HeatmapGroupingPoint.where(latitude: self.latitude, longitude: self.longitude).exists?
      errros.add :base, "Duplicate latitude longitude"
    end
  end

  validate do
    if self.latitude.to_s != self.latitude.to_f.round(3).to_s
      errors.add :latitude, "Bad accurancy"
    elsif self.longitude.to_s != self.longitude.to_f.round(3).to_s
      errors.add :longitude, "Bad accurancy"
    end
  end
end
