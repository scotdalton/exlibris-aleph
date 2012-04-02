require 'test_helper'
class TabHelperBenchmarks < ActiveSupport::TestCase
  def setup
    @adms = ["NYU50", "NYU51"]
    @tab_path = "/mnt/aleph_tab"
    dummy_path = "#{File.dirname(__FILE__)}/../dummy"
    @yml_path = File.join(dummy_path, "config/aleph")
    @log_path = File.join(dummy_path, "log/aleph")
    Exlibris::Aleph::TabHelper.class_variable_set(:@@adms, [])
    @TESTS = 10
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_init" do
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper init:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
      } }
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_refresh_yml" do
    Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper refresh_yml:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.refresh_yml()
      } }
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_new" do
    Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper new:") { @TESTS.times { 
        Exlibris::Aleph::TabHelper.send(:new)
      } }    
    end
  end

  # Get benchmarks for the Aleph TabHelper
  test "benchmarks_instance" do
    Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
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
    Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
    helper = Exlibris::Aleph::TabHelper.instance
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper refresh:") { @TESTS.times { 
        helper.send(:refresh)
      } }    
    end
  end
end