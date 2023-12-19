# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "flight_radar"
  spec.version       = "0.1.0"
  spec.authors       = ["Jakub Polak"]
  spec.email         = ["jakub.polak.vz@gmail.com"]

  spec.summary       = "Ruby gem for fetching aircraft data from Flightradar24"
  spec.description   = "To use this API see more information at: https://www.flightradar24.com/terms-and-conditions"
  spec.homepage      = "https://github.com/kupolak/flight_radar"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kupolak/flight_radar"
  spec.metadata["changelog_uri"] = "https://github.com/kupolak/flight_radar/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.21.0"

  spec.add_development_dependency "rake", "~>13.1.0"
  spec.add_development_dependency "rspec", "~>3.12.0"
  spec.add_development_dependency "rubocop", "~>1.59.0"
end
