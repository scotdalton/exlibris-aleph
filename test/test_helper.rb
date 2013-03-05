require 'coveralls'
Coveralls.wear!
require 'test/unit'
require File.expand_path("../../lib/exlibris-aleph.rb",  __FILE__)

# VCR is used to 'record' HTTP interactions with
# third party services used in tests, and play em
# back. Useful for efficiency, also useful for
# testing code against API's that not everyone
# has access to -- the responses can be cached
# and re-used. 
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock 
  # c.debug_logger = $stderr
  c.filter_sensitive_data("library.edu") { "library.nyu.edu" }
end

class Test::Unit::TestCase

  def yaml_aleph_configuration
    Exlibris::Aleph.configure do |config|
      config.load_yaml File.expand_path("../support/config.yml",  __FILE__)
    end
  end
  protected :yaml_aleph_configuration

  def reset_aleph_configuration
    Exlibris::Aleph.configure do |config|
      config.base_url = nil
      config.rest_url = nil
      config.adms = nil
      config.refresh_time = nil
      config.tab_path = nil
      config.yml_path = nil
      config.logger = nil
      config.irrelevant_sub_libraries = nil
      config.load_time = nil
    end
  end
  protected :reset_aleph_configuration
end