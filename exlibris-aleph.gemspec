$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exlibris/aleph/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exlibris-aleph"
  s.version     = Exlibris::Aleph::VERSION
  s.authors     = ["Scot Dalton"]
  s.email       = ["scotdalton@gmail.com"]
  s.homepage    = "https://github.com/scotdalton/exlibris-aleph"
  s.summary     = "Library to work with Exlibris' Aleph ILS."
  s.description = "Library to handle Exlibris' Aleph ILS."

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rake", "~> 10.1.0"
  s.add_dependency "rdoc", "~> 4.0.1"
  s.add_dependency "require_all", "~> 1.3.1"
  s.add_dependency "nokogiri", "~> 1.6.0"
  s.add_dependency "httparty", "~> 0.11.0"
  # Leverage ActiveSupport core extensions
  s.add_dependency "activesupport", "~> 3.2.14"
  # ActiveSupport core extensions use Builder
  # Version accounts for older Builder used in ActiveModel
  # in downstream apps.
  s.add_dependency "builder", ">= 3.0.0"
  s.add_dependency "marc", "~> 0.7.1"
  s.add_development_dependency "vcr", "~> 2.5.0"
  s.add_development_dependency "webmock", "~> 1.13.0"
end
