# frozen_string_literal: true

require_relative 'flight_radar/core'
require_relative 'flight_radar/request'
require_relative 'flight_radar/flight'

# FlightRadar module for sending requests to FlightRadar24 API
module FlightRadar
  VERSION = '0.3.0'

  module_function

  # Default configuration parameters for FlightRadar requests.
  @config = {
    faa: '1',
    satellite: '1',
    mlat: '1',
    flarm: '1',
    adsb: '1',
    gnd: '1',
    air: '1',
    vehicles: '1',
    estimated: '1',
    maxage: '14400',
    gliders: '1',
    stats: '1',
    limit: '5000'
  }

  # Retrieves a list of airlines.
  #
  # @return [Array] An array containing information about airlines.
  def airlines
    request = Request.new(Core::AIRLINES_DATA_URL, Core::JSON_HEADERS)
    request.content['rows']
  end

  # Retrieves airline logos based on IATA and ICAO codes.
  #
  # @param iata [String] The IATA code of the airline.
  # @param icao [String] The ICAO code of the airline.
  # @return [Array] An array containing URLs of airline logos.
  def airline_logo(iata, icao)
    first_logo_url = "#{Core::AIRLINE_LOGO_URL}#{iata}_#{icao}.png"
    second_logo_url = "#{Core::ALTERNATIVE_AIRLINE_LOGO_URL}#{icao}_logo0.png"

    # Check the availability of logos and return URLs.
    result = []
    first_request = Request.new(first_logo_url, Core::IMAGE_HEADERS)
    second_request = Request.new(second_logo_url, Core::IMAGE_HEADERS)
    result << first_logo_url if first_request.success?
    result << second_logo_url if second_request.success?
    result
  end

  # Retrieves traffic statistics for a specific airport.
  #
  # @param code [String] The code of the airport.
  # @return [Hash] A hash containing traffic statistics for the specified airport.
  def airport(code)
    url = "#{Core::DATA_LIVE_BASE_URL}/airports/traffic-stats/?airport=#{code}"
    request = Request.new(url, Core::JSON_HEADERS)
    request.content
  end

  # Retrieves a list of airports.
  #
  # @return [Array] An array containing information about airports.
  def airports
    request = Request.new(Core::AIRPORTS_DATA_URL, Core::JSON_HEADERS)
    request.content['rows']
  end

  # Converts zone information into bounds string.
  #
  # @param zone [Hash] A hash containing zone information.
  # @return [String] A string containing bounds information.
  def bounds(zone)
    "#{zone['tl_y']},#{zone['br_y']},#{zone['tl_x']},#{zone['br_x']}"
  end

  # Retrieves the URL of a country flag based on the country name.
  #
  # @param country [String] The name of the country.
  # @return [String] The URL of the country flag.
  def country_flag(country)
    "#{Core::COUNTRY_FLAG_URL}#{country.downcase.gsub(' ', '-')}.gif"
  end

  # Retrieves detailed information about a specific flight.
  #
  # @param flight_id [String] The ID of the flight.
  # @return [Hash] A hash containing detailed information about the specified flight.
  def flight_details(flight_id)
    HTTParty.get("https://data-live.flightradar24.com/clickhandler/?flight=#{flight_id}").parsed_response
  end

  # Retrieves a list of flights based on specified parameters.
  #
  # @param params [Hash] (optional) Parameters for filtering flights.
  # @return [Array] An array containing Flight objects.
  def flights(params = {})
    request_params = @config.dup
    request_params[:airline] = params[:airline] if params[:airline]
    request_params[:bounds] = params[:bounds]&.gsub(',', '%2C')

    response = Request.new(Core::REAL_TIME_FLIGHT_TRACKER_DATA_URL, Core::JSON_HEADERS, request_params).content

    %w[full_count version stats].each { |k| response.delete(k) }

    response.map { |flight_id, flight_details| Flight.new(flight_id, flight_details) }
  end

  # Retrieves information about flight tracking zones.
  #
  # @return [Hash] A hash containing information about flight tracking zones.
  def zones
    request = Request.new(Core::ZONES_DATA_URL, Core::JSON_HEADERS)
    content = request.content
    content.delete('version')
    content
  end

  # Searches for flights, airports, and airlines.
  #
  # @param query [String] The search query (e.g., flight number, airport code, airline name).
  # @param limit [Integer] (optional) Maximum number of results to return (default: 50).
  # @return [Hash] A hash containing search results grouped by type.
  def search(query, limit = 50)
    url = "#{Core::SEARCH_DATA_URL}?query=#{query}&limit=#{limit}"
    request = Request.new(url, Core::JSON_HEADERS)
    request.content
  end

  # Retrieves a list of the most tracked flights.
  #
  # @return [Hash] A hash containing information about the most tracked flights.
  def most_tracked
    request = Request.new(Core::MOST_TRACKED_URL, Core::JSON_HEADERS)
    request.content
  end

  # Retrieves playback data for a specific flight (alias for flight_details with version parameter).
  #
  # @param flight_id [String] The ID of the flight.
  # @return [Hash] A hash containing detailed playback information including flight path.
  def flight_playback(flight_id)
    flight_details(flight_id)
  end

  # Retrieves information about a specific aircraft by registration number.
  #
  # @param registration [String] The aircraft registration number (e.g., "N12345").
  # @return [Hash] A hash containing search results for the aircraft.
  def aircraft(registration)
    search(registration)
  end

  # Retrieves fleet information for a specific airline.
  #
  # @param airline_code [String] The airline code (IATA or ICAO).
  # @return [Hash] A hash containing information about the airline's fleet.
  def airline_fleet(airline_code)
    search(airline_code)
  end
end
