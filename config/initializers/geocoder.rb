Geocoder.configure(
    units: :km,
    language: :en,
    ip_lookup: :geoip2,
    geoip2: { file: Rails.root.join('db', 'maxmind', 'GeoLite2-City.mmdb') },
    # lookup: :bing,
    # key: bing_api_key,
    # api_key: bing_api_key,
    cache: Rails.cache,
    timeout: 5
)
# Geocoder::Configuration.language = :en

module Geocoder
  module Request
    alias_method :old_geocoder_spoofable_ip, :geocoder_spoofable_ip

    def geocoder_spoofable_ip
      ip = self.old_geocoder_spoofable_ip
      ip = ip.to_s.split(":").first if ip.include?(".") && ip.include?(":")
      ip
    end
  end
end