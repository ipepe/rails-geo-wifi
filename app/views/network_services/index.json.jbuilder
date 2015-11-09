json.array!(@network_services) do |place|
  json.type 'Feature'
  json.geometry do
    json.type "Point"
    json.coordinates place.geojson_coordinates
  end
  json.properties do
    json.id place.id
    json.ssid place.ssid
  end
end
