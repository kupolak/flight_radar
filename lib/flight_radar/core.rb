module Core
  CDN_FLIGHT_RADAR_BASE_URL = "https://cdn.flightradar24.com"
  FLIGHT_RADAR_BASE_URL = "https://www.flightradar24.com"
  DATA_LIVE_BASE_URL = "https://data-live.flightradar24.com"

  # Flights data URLs.
  REAL_TIME_FLIGHT_TRACKER_DATA_URL = "#{DATA_LIVE_BASE_URL}/zones/fcgi/feed.js"
  FLIGHT_DATA_URL = "#{DATA_LIVE_BASE_URL}/clickhandler/?flight="

  # Airports data URLs.
  AIRPORT_DATA_URL = "#{FLIGHT_RADAR_BASE_URL}/airports/traffic-stats/?airport="
  AIRPORTS_DATA_URL = "#{FLIGHT_RADAR_BASE_URL}/_json/airports.php"

  # Airlines data URL.
  AIRLINES_DATA_URL = "#{FLIGHT_RADAR_BASE_URL}/_json/airlines.php"

  # Zones data URL.
  ZONES_DATA_URL = "#{FLIGHT_RADAR_BASE_URL}/js/zones.js.php"

  # Country flag image URL.
  COUNTRY_FLAG_URL = "#{FLIGHT_RADAR_BASE_URL}/static/images/data/flags-small/"

  # Airline logo image URL.
  AIRLINE_LOGO_URL = "#{CDN_FLIGHT_RADAR_BASE_URL}/assets/airlines/logotypes/"
  ALTERNATIVE_AIRLINE_LOGO_URL = "#{FLIGHT_RADAR_BASE_URL}/static/images/data/operators/"

  HEADERS = {
    "accept-encoding": "gzip, br",
    "accept-language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "cache-control": "max-age=0",
    "origin": "https://www.flightradar24.com",
    "referer": "https://www.flightradar24.com/",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-site",
    "user-agent": "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"
  }

  JSON_HEADERS = HEADERS
  JSON_HEADERS["accept"] = "application/json"

  IMAGE_HEADERS = HEADERS
  IMAGE_HEADERS["accept"] = "image/gif, image/jpg, image/jpeg, image/png"
end
