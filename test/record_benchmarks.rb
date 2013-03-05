require 'test_helper'
class RecordBenchmarks < ActiveSupport::TestCase
  def setup
    @rest_url = "http://aleph.library.nyu.edu:1891/rest-dlf"
    @aleph_doc_library = "NYU01"
    @aleph_doc_number = "000062856"
    @bogus_url = "http://library.nyu.edu/bogus"
    @TESTS = 10
  end

  # Get benchmarks for calls to the Aleph API.
  test "benchmarks" do
    # Display performance benchmarks.
    time = Benchmark.bmbm do |results|
      results.report("Aleph items:") { @TESTS.times { 
        aleph_record = Exlibris::Aleph::Record.new(@aleph_doc_library, @aleph_doc_number, @rest_url)
        items = aleph_record.items 
      } }    
      results.report("Aleph bib and holdings:") { @TESTS.times { 
        aleph_record = Exlibris::Aleph::Record.new(@aleph_doc_library, @aleph_doc_number, @rest_url)
        items = aleph_record.bib 
        items = aleph_record.holdings 
      } }    
    end
  end
end