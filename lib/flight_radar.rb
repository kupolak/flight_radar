# frozen_string_literal: true

require_relative 'flight_radar/core'
require_relative 'flight_radar/request'
require_relative 'flight_radar/flight'

# FlightRadar module for sending requests to FlightRadar24 API
module FlightRadar
  VERSION = '0.2.0'

  module_function

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

  def airlines
    request = Request.new(Core::AIRLINES_DATA_URL, Core::JSON_HEADERS)
    request.content['rows']
  end

  def airline_logo(iata, icao)
    first_logo_url = "#{Core::AIRLINE_LOGO_URL}#{iata}_#{icao}.png"
    second_logo_url = "#{Core::ALTERNATIVE_AIRLINE_LOGO_URL}#{icao}_logo0.png"

    # check status codes
    result = []
    first_request = Request.new(first_logo_url, Core::IMAGE_HEADERS)
    second_request = Request.new(second_logo_url, Core::IMAGE_HEADERS)
    result << first_logo_url if first_request.status_code[0] != 4
    result << second_logo_url if second_request.status_code[0] != 4
    [first_logo_url, second_logo_url]
  end

  def airport(code)
    HTTParty.get("https://data-live.flightradar24.com/airports/traffic-stats/?airport=#{code}").parsed_response
  end

  def airports
    request = Request.new(Core::AIRPORTS_DATA_URL, Core::JSON_HEADERS)
    request.content['rows']
  end

  def bounds(zone)
    "#{zone['tl_y']},#{zone['br_y']},#{zone['tl_x']},#{zone['br_x']}"
  end

  def country_flag(country)
    "#{Core::COUNTRY_FLAG_URL}#{country.downcase.gsub(' ', '-')}.gif"
  end

  def flight_details(flight_id)
    HTTParty.get("https://data-live.flightradar24.com/clickhandler/?flight=#{flight_id}").parsed_response
  end

  def flights(params = {})
    request_params = @config.dup
    request_params[:airline] = params[:airline] if params[:airline]
    request_params[:bounds] = params[:bounds]&.gsub(',', '%2C')

    response = Request.new(Core::REAL_TIME_FLIGHT_TRACKER_DATA_URL, Core::JSON_HEADERS, request_params).content

    %w[full_count version stats].each { |k| response.delete(k) }

    response.map { |flight_id, flight_details| Flight.new(flight_id, flight_details) }
  end

  def zones
    request = Request.new(Core::ZONES_DATA_URL, Core::JSON_HEADERS)
    request = request.content
    request.delete('version')
    request
  end
end
