# class GeographicPoint < ActiveRecord::Base
#   # self.abstract_class = true
#
#   validates_presence_of :latitude, :longitude
#
#   scope :with_coordinates, -> do
#     where.not(latitude: nil, longitude: nil)
#   end
#
#   scope :warsaw_area, -> do
#     where(latitude: (52.1..52.3), longitude: (20.8..21.2))
#   end
# end