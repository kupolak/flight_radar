# frozen_string_literal: true

require_relative 'lib/flight_radar/version'

Gem::Specification.new do |spec|
  spec.name          = 'flight_radar'
  spec.version       = FlightRadar::VERSION
  spec.authors       = ['Jakub Polak']
  spec.email         = ['jakub.polak.vz@gmail.com']

  spec.summary       = 'Ruby gem for fetching aircraft data from Flightradar24'
  spec.description   = 'Unofficial Ruby wrapper for Flightradar24 API. Fetch real-time flight data, ' \
                       'airport statistics, airline information, and more. For terms see: ' \
                       'https://www.flightradar24.com/terms-and-conditions'
  spec.homepage      = 'https://github.com/kupolak/flight_radar'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['documentation_uri'] = 'https://kupolak.github.io/flight_radar/'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '>= 0.21', '< 0.24'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
