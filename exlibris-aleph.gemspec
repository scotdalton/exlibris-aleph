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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "nokogiri"
  s.add_dependency "httparty"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
