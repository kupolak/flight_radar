# frozen_string_literal: true

# The `Flight` class represents information about a flight obtained from a data source.
# It provides methods to access and format various attributes related to the flight,
# such as altitude, ground speed, heading, and more.
class Flight
  DEFAULT_TEXT = 'N/A'

  # Accessor for the flight ID.
  attr_accessor :id

  # Initializes a new instance of the `Flight` class with the given flight ID and information.
  #
  # @param flight_id [String] The unique identifier for the flight.
  # @param info [Array<String>] An array containing various information about the flight.
  #   The order of elements in the array is assumed to follow a specific pattern.
  #   (e.g., info[0] is ICAO 24-bit address, info[1] is latitude, info[2] is longitude, and so on.)
  # rubocop:disable Metrics
  def initialize(flight_id, info)
    @id = flight_id
    @icao_24bit = get_info(info[0])
    @latitude = get_info(info[1])
    @longitude = get_info(info[2])
    @heading = get_info(info[3])
    @altitude = get_info(info[4])
    @ground_speed = get_info(info[5])
    @squawk = get_info(info[6])
    @aircraft_code = get_info(info[8])
    @registration = get_info(info[9])
    @time = get_info(info[10])
    @origin_airport_iata = get_info(info[11])
    @destination_airport_iata = get_info(info[12])
    @number = get_info(info[13])
    @airline_iata = get_info(info[13][0..1])
    @on_ground = get_info(info[14])
    @vertical_speed = get_info(info[15])
    @callsign = get_info(info[16])
    @airline_icao = get_info(info[18])
  end
  # rubocop:enable Metrics

  # Returns a string representation of the `Flight` object.
  #
  # @return [String] A formatted string containing relevant information about the flight.
  def to_s
    "<(#{@aircraft_code}) #{@registration}
    - Altitude: #{@altitude}
    - Ground Speed: #{@ground_speed}
    - Heading: #{@ground_speed}>"
  end

  # Returns a formatted string representing the altitude of the flight.
  #
  # @return [String] Formatted altitude string (e.g., "5000 ft").
  def altitude
    "#{@altitude} ft"
  end

  # Returns a formatted string representing the flight level based on altitude.
  #
  # @return [String] Formatted flight level string (e.g., "FL350").
  def flight_level
    @altitude > 10_000 ? "#{@altitude[0..2]} FL" : altitude
  end

  # Returns a formatted string representing the ground speed of the flight.
  #
  # @return [String] Formatted ground speed string (e.g., "300 kts").
  def ground_speed
    speed = "#{@ground_speed} kt"
    speed += 's' if @ground_speed > 1
    speed
  end

  # Returns a formatted string representing the heading of the flight.
  #
  # @return [String] Formatted heading string (e.g., "120°").
  def heading
    "#{@heading}°"
  end

  # Returns a formatted string representing the vertical speed of the flight.
  #
  # @return [String] Formatted vertical speed string (e.g., "1000 fpm").
  def vertical_speed
    "#{@vertical_speed} fpm"
  end

  private

  # Helper method to ensure that the information is not nil or the default text.
  #
  # @param info [String] The information to be validated.
  # @return [String] The original information if it is not nil or the default text.
  def get_info(info)
    info && info != DEFAULT_TEXT ? info : DEFAULT_TEXT
  end
end
