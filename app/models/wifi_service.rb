class WifiService < ActiveRecord::Base

  has_many :wifi_names, through: :wifi_observations
  has_many :wifi_observations
  belongs_to :heatmap_grouping_point
  validates_presence_of :bssid
  validates_presence_of :wifi_observations, :latitude, :longitude, on: :update

  after_create do
    self.recalculate_position
    self.save
  end

  scope :with_coordinates, -> do
    where.not(latitude: nil, longitude: nil)
  end

  scope :warsaw_area, -> do
    where(latitude: (52.1..52.3), longitude: (20.8..21.2))
  end

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

  def assign_heatmap_group
    self.heatmap_grouping_point = HeatmapGroupingPoint.find_or_create_by!(
        {
            latitude: self.latitude.round(3),
            longitude: self.longitude.round(3)
        })
  end

  def self.assign_heatmap_groups(only_nil = true)
    scope = WifiService
    scope = scope.where(heatmap_grouping_point_id: nil) if only_nil
    scope.includes(:wifi_observations, :wifi_names).find_in_batches(batch_size: 2000) do |group|
      group.each do |service|
        service.assign_heatmap_group
        service.save!
        service.heatmap_grouping_point.update_count
      end
    end
  end

  def recalculate_position
    observations = self.wifi_observations.to_a
    if observations.size > 0
      self.latitude = observations.map(&:latitude).sum / observations.size
      self.longitude = observations.map(&:longitude).sum / observations.size
    end
    self.assign_heatmap_group
  end

  def self.recalculate_positions(only_nil = true)
    scope = WifiService
    scope = scope.where(latitude: nil, longitude: nil) if only_nil
    scope.includes(:wifi_observations, :wifi_names).find_in_batches(batch_size: 2000) do |group|
      WifiService.transaction do
        group.each do |service|
          service.recalculate_position
          service.save
        end
      end
    end
  end

  def ssids
    self.wifi_names.map(&:ssid)
  end

  def geojson_coordinates
    [self.longitude, self.latitude]
  end

  def geojson_hash
    Rails.cache.fetch("#{cache_key}/geojson_hash") do
      {
          type: 'Feature',
          geometry: {
              type: 'Point',
              coordinates: self.geojson_coordinates
          },
          properties: {
              id: self.id,
              bssid: self.bssid,
              ssids: self.ssids,
              display_name: self.display_name
          }
      }
    end
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
