require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def test_config
    reset_aleph_configuration
    Exlibris::Aleph.configure do |config|
      config.base_url = "test_url"
      config.adms = ["ADM1", "ADM2"]
    end
    assert_equal "test_url", Exlibris::Aleph::Config.base_url
    assert_equal "test_url:1891/rest-dlf", Exlibris::Aleph::Config.rest_url
    assert_equal ["ADM1", "ADM2"], Exlibris::Aleph::Config.adms
    reset_aleph_configuration
  end

  def test_config_from_yaml
    reset_aleph_configuration
    yaml_aleph_configuration
    assert_equal "http://aleph.library.nyu.edu", Exlibris::Aleph::Config.base_url
    assert_equal "http://aleph.library.nyu.edu:1891/rest-dlf", Exlibris::Aleph::Config.rest_url
    assert_equal ["NYU50", "NYU51"], Exlibris::Aleph::Config.adms
    assert_nil(Exlibris::Aleph::Config.tab_path)
    reset_aleph_configuration
  end
end