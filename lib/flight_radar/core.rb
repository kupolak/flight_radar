# frozen_string_literal: true

module Core
  API_FLIGHT_RADAR_BASE_URL = "https://api.flightradar24.com/common/v1"
  CDN_FLIGHT_RADAR_BASE_URL = "https://cdn.flightradar24.com"
  FLIGHT_RADAR_BASE_URL = "https://www.flightradar24.com"
  DATA_LIVE_BASE_URL = "https://data-live.flightradar24.com"
  DATA_CLOUD_BASE_URL = "https://data-cloud.flightradar24.com"

  # User login URL.
  USER_LOGIN_URL = "#{FLIGHT_RADAR_BASE_URL}/user/login"
  USER_LOGOUT_URL = "#{FLIGHT_RADAR_BASE_URL}/user/logout"

  # Most tracked data URL
  MOST_TRACKED_URL = "#{FLIGHT_RADAR_BASE_URL}/flights/most-tracked"

  # Search data URL
  SEARCH_DATA_URL = "#{FLIGHT_RADAR_BASE_URL}/v1/search/web/find?query={}&limit=50"

  # Flights data URLs.
  REAL_TIME_FLIGHT_TRACKER_DATA_URL = "#{DATA_CLOUD_BASE_URL}/zones/fcgi/feed.js"
  FLIGHT_DATA_URL = "#{DATA_LIVE_BASE_URL}/clickhandler/?flight={}"

  # Airports data URLs.
  API_AIRPORT_DATA_URL = "#{API_FLIGHT_RADAR_BASE_URL}/airport.json"
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
    "origin": "#{FLIGHT_RADAR_BASE_URL}",
    "referer": "#{FLIGHT_RADAR_BASE_URL}/",
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
