require 'test_helper'
class TabHelperBenchmarks < ActiveSupport::TestCase
  def setup
    @adms = ["NYU50", "NYU51"]
    @tab_path = "/mnt/aleph_tab"
    Exlibris::Aleph::TabHelper.class_variable_set(:@@adms, [])
    [ :@@patrons_path,
      :@@items_path,
      :@@item_permissions_by_item_status_path,
      :@@item_permissions_by_item_process_status_path,
      :@@collections_path,
      :@@pickup_locations_path ].each { |class_variable|
        Exlibris::Aleph::TabHelper.class_variable_set(class_variable, {}) }
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
  test "benchmarks_new" do
    Exlibris::Aleph::TabHelper.init(@tab_path, @adms)
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("TabHelper new:") { @TESTS.times { 
        [ :@@patrons_path,
          :@@items_path,
          :@@item_permissions_by_item_status_path,
          :@@item_permissions_by_item_process_status_path,
          :@@collections_path,
          :@@pickup_locations_path ].each { |class_variable|
            Exlibris::Aleph::TabHelper.class_variable_set(class_variable, {}) }
        Exlibris::Aleph::TabHelper.send(:new)
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
        helper.refresh
      } }    
    end
  end
end