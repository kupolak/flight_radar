# frozen_string_literal: true

class Flight
  @default_text = "N/A"

  attr_accessor :id

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

  def inspect
    to_s
  end

  def to_s
    "<(#{@aircraft_code}) #{@registration} - Altitude: #{@altitude} - Ground Speed: #{@ground_speed} - Heading: #{@ground_speed}>"
  end

  def altitude
    "#{@altitude} ft"
  end

  def flight_level
    if @altitude > 10_000
      "#{@altitude[0..2]} FL"
    else
      altitude
    end
  end

  def ground_speed
    speed = "#{@ground_speed} kt"
    speed += "s" if @ground_speed > 1
    speed
  end

  def heading
    "#{@heading}°"
  end

  def vertical_speed
    "#{@vertical_speed} fpm"
  end

  private

  def get_info(info)
    if (info || info.zero?) && (info != @default_text)
      info
    else
      @default_text
    end
  end
end
