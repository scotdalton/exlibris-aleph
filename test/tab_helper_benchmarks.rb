require 'test_helper'
class TabHelperBenchmarks < ActiveSupport::TestCase
  def setup
    Exlibris::Aleph.configure { |c|
      c.adms = ["NYU50", "NYU51"]
      c.tab_path = "#{File.dirname(__FILE__)}/mnt/aleph_tab"
      c.yml_path = File.join(File.dirname(__FILE__), "config/aleph")
    }
    @TESTS = 10
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_refresh_yml" do
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper refresh_yml:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.refresh_yml()
      } }
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_new" do
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper new:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.send(:new)
      } }    
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_instance" do
    Exlibris::Aleph::TabHelper.send(:new)
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper instance:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.instance
      } }    
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_refresh" do
    helper = Exlibris::Aleph::TabHelper.instance
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper refresh:") { @TESTS.times { 
        helper.send(:refresh)
      } }    
    end
  end
end