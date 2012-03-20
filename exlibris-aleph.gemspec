$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exlibris-aleph/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exlibris-aleph"
  s.version     = ExlibrisAleph::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ExlibrisAleph."
  s.description = "TODO: Description of ExlibrisAleph."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "httparty"
end
