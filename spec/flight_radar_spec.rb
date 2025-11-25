# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe FlightRadar do
  it 'gets airlines' do
    result = FlightRadar.airlines
    expect(result.count).to be >= 100
  end

  it 'gets airports' do
    airports = FlightRadar.airports
    expect(airports.count).to be > 4000
  end

  it 'gets airport' do
    airports = %w[ATL LAX DXB DFW]
    count = 0
    airports.each do |airport|
      count += 1 if FlightRadar.airport(airport) != {}
    end
    expect(count).to be >= 3
  end

  it 'gets zones' do
    result = FlightRadar.zones
    check = %w[europe northamerica southamerica oceania asia africa atlantic maldives northatlantic].all? do |s|
      result.key? s
    end
    expect(check).to be_truthy
  end

  it 'gets flights' do
    result = FlightRadar.flights
    expect(result.count).to be >= 100
  end

  it 'gets flight details' do
    flight = FlightRadar.flights
    flight = flight.sample
    flight_details = FlightRadar.flight_details(flight.id)
    expect(flight_details['identification']['id']).to be == flight.id
  end

  it 'gets flights by airline' do
    airlines = %w[SWA GLO AZU UAL THY]
    count = 0
    airlines.each do |airline|
      count += 1 if FlightRadar.flights(airline:)
    end
    expect(count).to be >= 3
  end

  it 'gets flights by bounds' do
    zone = FlightRadar.zones['europe']
    bounds = FlightRadar.bounds(zone)
    result = FlightRadar.flights(bounds:)
    expect(result.count).to be >= 30
  end

  it 'gets airline logo' do
    airline = [%w[WN SWA], %w[G3 GLO], %w[AD AZU], %w[AA AAL], %w[TK THY]].sample
    logo = FlightRadar.airline_logo(airline[0], airline[1])
    expect(logo).to be_an(Array)
    expect(logo.length).to be >= 1
    expect(logo.first).to match(%r{^https://})
  end

  it 'gets country flag' do
    country = 'United States'
    flag_url = FlightRadar.country_flag(country)
    expect(flag_url).to eq 'https://www.flightradar24.com/static/images/data/flags-small/united-states.gif'
  end

  it 'searches for flights, airports, and airlines' do
    result = FlightRadar.search('LOT', 10)
    expect(result).to be_a(Hash)
    expect(result.key?('results')).to be_truthy
    expect(result['results']).to be_an(Array)
    expect(result['results'].length).to be >= 1
  end

  it 'gets most tracked flights' do
    result = FlightRadar.most_tracked
    expect(result).to be_a(Hash)
    expect(result.key?('data')).to be_truthy
    expect(result['data']).to be_an(Array)
    expect(result['data'].length).to be >= 1
  end

  it 'gets flight playback data' do
    flights = FlightRadar.flights
    flight = flights.sample
    result = FlightRadar.flight_playback(flight.id)
    expect(result).to be_a(Hash)
  end

  it 'searches for aircraft by registration' do
    result = FlightRadar.aircraft('N')
    expect(result).to be_a(Hash)
    expect(result.key?('results')).to be_truthy
  end

  it 'searches for airline fleet' do
    result = FlightRadar.airline_fleet('AA')
    expect(result).to be_a(Hash)
    expect(result.key?('results')).to be_truthy
  end
end
# rubocop:enable Metrics/BlockLength
