$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'exlibris/aleph/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'exlibris-aleph'
  s.version     = Exlibris::Aleph::VERSION
  s.authors     = ['Scot Dalton']
  s.email       = ['scotdalton@gmail.com']
  s.homepage    = 'https://github.com/scotdalton/exlibris-aleph'
  s.summary     = "Library to work with Exlibris' Aleph ILS."
  s.description = "Library to handle Exlibris' Aleph ILS."
  s.license     = 'MIT'

  s.files = Dir['lib/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rake', '~> 10.3.0'
  s.add_dependency 'require_all', '~> 1.3.0'
  s.add_dependency 'multi_xml', '~> 0.5.0'
  s.add_dependency 'faraday', '~> 0.8.0'
  s.add_dependency 'marc', '~> 0.8.0'

  s.add_development_dependency 'rspec', '~> 2.14.0'
  s.add_development_dependency 'vcr', '~> 2.9.0'
  s.add_development_dependency 'nokogiri', '~> 1.6.0'
end
