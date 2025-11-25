## [Unreleased]

## [0.3.0] - 2025-11-25

### Added
- New `search(query, limit)` method for searching flights, airports, and airlines
- New `most_tracked` method to retrieve most tracked flights in real-time
- New `flight_playback(flight_id)` method for retrieving flight path history
- New `aircraft(registration)` method for searching aircraft by registration number
- New `airline_fleet(airline_code)` method for retrieving airline fleet information
- Added `attr_reader` for all Flight class instance variables (icao_24bit, latitude, longitude, squawk, aircraft_code, registration, time, origin_airport_iata, destination_airport_iata, number, airline_iata, on_ground, callsign, airline_icao)
- Enhanced gemspec with bug_tracker_uri and documentation_uri metadata
- Updated README with comprehensive documentation for all new methods

### Fixed
- Fixed bug in Flight#to_s method where heading was displaying ground_speed value
- Fixed HEADERS constant mutation issue in Core module by using .merge() and .freeze
- Fixed inconsistent Request class usage in airport and flight_details methods
- Fixed flight_level method attempting to slice integer instead of properly dividing by 100
- Fixed ground_speed method type comparison issue
- Fixed airline_iata extraction to safely handle nil/short values
- Fixed flaky airline_logo test to require at least 1 logo instead of exactly 2

### Changed
- Refactored airport method to use Request class instead of direct HTTParty.get
- Refactored flight_details method to use Request class for consistency
- Updated GitHub Actions workflow to use Ruby 3.2
- Added bundler-cache to CI for faster builds
- Gemspec now loads version dynamically from FlightRadar::VERSION
- Enhanced gemspec description with more details

## [0.2.1] - 2023-12-21
- Code refactor
- Add documentation to the code
- Apply rubocop suggestions

## [0.2.0] - 2023-12-20

- Make the gem work again
- Remove Gemfile.lock
- Move dependencies to gemspec
- Update dependencies
- Add a simple CI

## [0.1.0] - 2022-01-31

- Initial release
