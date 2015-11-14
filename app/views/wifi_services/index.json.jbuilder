json.array!(@wifi_services) do |service|
  json.type 'Feature'
  json.geometry do
    json.type "Point"
    json.coordinates service.geojson_coordinates
  end
  json.properties do
    json.id service.id
    json.display_name service.display_name
  end
end
