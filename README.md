<img src="https://www.flightradar24.com/blog/wp-content/uploads/2020/04/Hi_Res_Transparent-2.jpg" width="200"/>


**Fetch aircraft data from Flightradar24.**

# Table of Contents
- [Installation](#installation)
- [Usage](#usage)
    - [Airlines](#airlines)
    - [Airport](#airport)
    - [Airports](#airports)
    - [Zones](#zones)
    - [Flights](#flights)
    - [Flight Details](#flight-details)
    - [Flight Playback](#flight-playback)
    - [Flights by Airline](#flights-by-airline)
    - [Flights by Bounds](#flights-by-bounds)
    - [Search](#search)
    - [Most Tracked Flights](#most-tracked-flights)
    - [Aircraft Information](#aircraft-information)
    - [Airline Fleet](#airline-fleet)
    - [Airline Logo](#airline-logo)
    - [Country Flag](#country-flag)
- [Documentation](#documentation)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flight_radar'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install flight_radar

## Usage

### Airlines

```ruby
FlightRadar.airlines
```

**Sample response:**

```ruby
[
  {"Name"=>"21 Air", "Code"=>"2I", "ICAO"=>"CSB"},
  {"Name"=>"25Only Aviation", "Code"=>"", "ICAO"=>"ONY"},
  {"Name"=>"40-Mile Air", "Code"=>"Q5", "ICAO"=>"MLA"},
# ...
]
```

### Airport

Get traffic statistics for a specific airport.

```ruby
FlightRadar.airport("LAX")
```

**Sample response:**

```ruby
{
  "details" => {
    "name" => "Los Angeles International Airport",
    "code" => {
      "iata" => "LAX",
      "icao" => "KLAX"
    },
    "position" => {
      "latitude" => 33.942536,
      "longitude" => -118.408075,
      "altitude" => 125,
      "country" => {
        "name" => "United States",
        "code" => "USA"
      },
      "region" => {
        "city" => "Los Angeles"
      }
    },
    # ...
  }
}
```

### Airports

Get a list of all airports.

```ruby
FlightRadar.airports
```

**Sample response:**

```ruby
[
  {"name" => "Hartsfield-Jackson Atlanta Intl", "iata" => "ATL", "icao" => "KATL", "lat" => 33.6367, "lon" => -84.4281},
  {"name" => "Los Angeles Intl", "iata" => "LAX", "icao" => "KLAX", "lat" => 33.9425, "lon" => -118.408},
  # ...
]
```

### Zones

```ruby
FlightRadar.zones
```

**Sample response:**
```ruby
{
  "europe" => {
    "tl_y" => 72.57,
    "tl_x" => -16.96,
    "br_y" => 33.57,
    "br_x" => 53.05,
    "subzones" => {
      "poland" => {
        "tl_y" => 56.86,
        "tl_x" => 11.06,
        "br_y" => 48.22,
        "br_x" => 28.26
      },
      "germany" => {
        "tl_y" => 57.92,
        "tl_x" => 1.81,
        "br_y" => 45.81,
        "br_x" => 16.83
      },
      # ...
    }
  }
}
```

### Flights

```ruby
FlightRadar.flights
```

**Sample response:**

```ruby
[
  "<(GRND) - Altitude: 0 - Ground Speed: 146 - Heading: 146>",
  "<(DRON) TEST4A - Altitude: 374 - Ground Speed: 1 - Heading: 1>",
  "<(GLID) STM32 - Altitude: 2290 - Ground Speed: 1 - Heading: 1>",
  "<() - Altitude: 508 - Ground Speed: 7 - Heading: 7>",
  "<(B763) N142FE - Altitude: 0 - Ground Speed: 0 - Heading: 0>",
  "<(GRND) - Altitude: 0 - Ground Speed: 278 - Heading: 278>",
  "<(GLID) OM-2709 - Altitude: 1236 - Ground Speed: 1 - Heading: 1>",
  "<(B763) N196FE - Altitude: 0 - Ground Speed: 0 - Heading: 0>",
  "<(B77L) N869FD - Altitude: 0 - Ground Speed: 0 - Heading: 0>",
  "<(B763) N111FE - Altitude: 0 - Ground Speed: 0 - Heading: 0>",
  "<(B763) N193FE - Altitude: 0 - Ground Speed: 0 - Heading: 0>",
# ...
]
```

### Flight Details

Get detailed information about a specific flight.

```ruby
flight_id = FlightRadar.flights.sample.id
FlightRadar.flight_details(flight_id)
```

**Sample response:**

```ruby
{
  "identification" => {
    "id" => "2aaadc48",
    "row" => 5175915984,
    "number" => {
      "default" => "F980",
      "alternative" => nil
    },
    "callsign" => "FFT80"
  },
  "status" => {
    "live" => true,
    "text" => "Estimated- 14:01",
    "icon" => "green",
    "estimated" => nil,
    "ambiguous" => false,
    "generic" => {
      "status" => {
        "text" => "estimated",
        "color" => "green",
        "type" => "arrival"
      },
      "eventTime" => {
        "utc" => 1643652087,
        "local" => 1643637687
      }
    }
  },
  # ...
}
```

### Flight Playback

Get playback data for a specific flight (includes full flight path history).

```ruby
flight_id = FlightRadar.flights.sample.id
FlightRadar.flight_playback(flight_id)
```

**Note:** This is an alias for `flight_details` and returns the same data structure.

### Flights by airline

```ruby
airline = "LOT"
FlightRadar.flights(airline: airline)
```

**Sample response:**

```ruby
[
  "<(B789) SP-LSG - Altitude: 39992 - Ground Speed: 451 - Heading: 451>",
  "<(B788) SP-LRA - Altitude: 38975 - Ground Speed: 537 - Heading: 537>",
  "<(B788) SP-LRB - Altitude: 38000 - Ground Speed: 463 - Heading: 463>",
  "<(E195) SP-LNF - Altitude: 31675 - Ground Speed: 420 - Heading: 420>",
  "<(B38M) SP-LVF - Altitude: 38000 - Ground Speed: 460 - Heading: 460>",
  "<(E195) SP-LNB - Altitude: 22475 - Ground Speed: 366 - Heading: 366>",
  "<(B789) SP-LSF - Altitude: 36000 - Ground Speed: 440 - Heading: 440>",
# ...
]
```

### Flights by bounds

```ruby
zone = FlightRadar.zones["oceania"]
bounds = FlightRadar.bounds(zone)
FlightRadar.flights(bounds: bounds)
```

**Sample response:**

```ruby
[
  "<(B788) VT-ANP - Altitude: 41000 - Ground Speed: 494 - Heading: 494>",
  "<(B738) VT-AXZ - Altitude: 37000 - Ground Speed: 436 - Heading: 436>",
  "<(B772) PH-BQA - Altitude: 32000 - Ground Speed: 496 - Heading: 496>",
  "<(A388) 9V-SKS - Altitude: 33996 - Ground Speed: 498 - Heading: 498>",
  "<(B77L) A7-BFY - Altitude: 32000 - Ground Speed: 478 - Heading: 478>",
  "<(B78X) 9V-SCA - Altitude: 38996 - Ground Speed: 514 - Heading: 514>",
  "<(B77W) A6-ENU - Altitude: 34000 - Ground Speed: 504 - Heading: 504>",
  "<(A359) OH-LWF - Altitude: 40004 - Ground Speed: 476 - Heading: 476>",
# ...
]
```


### Airline logo

```ruby
iata = "TK"
icao = "THY"
FlightRadar.airline_logo(iata, icao)
```

**Sample response:**

```ruby
%w[https://cdn.flightradar24.com/assets/airlines/logotypes/TK_THY.png https://www.flightradar24.com/static/images/data/operators/THY_logo0.png]
```


### Country flag

Get the URL of a country flag image.

```ruby
FlightRadar.country_flag("Poland")
```

**Sample response:**

```ruby
"https://www.flightradar24.com/static/images/data/flags-small/poland.gif"
```

### Search

Search for flights, airports, and airlines.

```ruby
FlightRadar.search("LOT", 10)
```

**Sample response:**

```ruby
{
  "results" => [
    {
      "id" => "LOT",
      "label" => "LOT (LOT / LO)",
      "detail" => {
        "operator_id" => 11,
        "iata" => "LO",
        "logo" => "https://cdn.flightradar24.com/assets/airlines/logotypes/11.png"
      },
      "type" => "operator",
      "match" => "icao",
      "name" => "LOT"
    },
    # ...
  ],
  "stats" => {
    "total" => {
      "all" => 42,
      "airport" => 12,
      "operator" => 15,
      "live" => 8
    }
  }
}
```

### Most Tracked Flights

Get the most tracked flights in real-time.

```ruby
FlightRadar.most_tracked
```

**Sample response:**

```ruby
{
  "data" => [
    {
      "flight_id" => "2abc1234",
      "flight" => "AA100",
      "callsign" => "AAL100",
      "squawk" => "1234",
      "clicks" => 5420,
      # ...
    },
    # ...
  ],
  "update_time" => 1700000000,
  "version" => 1
}
```

### Aircraft Information

Search for aircraft by registration number.

```ruby
FlightRadar.aircraft("N12345")
```

**Sample response:**

Returns search results similar to the `search` method, filtered for aircraft.

### Airline Fleet

Get fleet information for a specific airline.

```ruby
FlightRadar.airline_fleet("LOT")
```

**Sample response:**

Returns search results similar to the `search` method, showing airline and aircraft information.

## Documentation

Live documentation of the gem is available [at this GitHub page](https://kupolak.github.io/flight_radar/).

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kupolak/flight_radar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/flight_radar/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FlightRadar project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kupolak/flight_radar/blob/main/CODE_OF_CONDUCT.md).
