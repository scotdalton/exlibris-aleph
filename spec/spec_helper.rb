$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'coveralls'
Coveralls.wear!
require 'rspec'
require 'vcr'
require 'exlibris-aleph'

require 'pry'

VCR.configure do |config|
  config.hook_into :faraday
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.configure_rspec_metadata!
  config.filter_sensitive_data("library.edu") { "library.nyu.edu" }
  config.filter_sensitive_data("BOR_ID") { ENV['BOR_ID'] }
  config.filter_sensitive_data("VERIFICATION") { ENV['VERIFICATION'] }
end

Exlibris::Aleph.configure do |config|
  config.base_url = 'http://aleph.library.nyu.edu'
  config.adms = ['NYU50', 'NYU51']
  config.table_path = "#{File.dirname(__FILE__)}/support/mnt/aleph_tab"
end
