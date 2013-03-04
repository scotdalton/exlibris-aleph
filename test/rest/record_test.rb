require 'test_helper'
class RecordTest < ActiveSupport::TestCase
  def setup
    @rest_url = "http://aleph.library.nyu.edu:1891/rest-dlf"
    @aleph_doc_library = "NYU01"
    @aleph_doc_number = "000062856"
    @bogus_url = "http://library.nyu.edu/bogus"
  end

  # Test exception handling for bogus url
  test "bogus_response" do
    VCR.use_cassette('record bogus url') do
      aleph_record = Exlibris::Aleph::Rest::Record.new(bib_library: @aleph_doc_library, record_id: @aleph_doc_number, rest_url: @bogus_url)
      assert_raise(RuntimeError) { aleph_record.bib }
      assert_raise(MultiXml::ParseError) { aleph_record.holdings }
      assert_raise(MultiXml::ParseError) { aleph_record.items }
    end
  end

  # Test record.
  test "record" do
    VCR.use_cassette('record') do
      aleph_record = Exlibris::Aleph::Rest::Record.new(bib_library: @aleph_doc_library, record_id: @aleph_doc_number, rest_url: @rest_url)
      bib = aleph_record.bib
      assert_kind_of String, bib
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling bib: #{aleph_record.error}")
      holdings = aleph_record.holdings
      assert_kind_of Array, holdings
      holdings.each { |holding| assert_kind_of Hash, holding }
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling holdings: #{aleph_record.error}")
      items = aleph_record.items
      assert_kind_of Array, items
      items.each { |item| assert_kind_of Hash, item }
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling items: #{aleph_record.error}")
    end
  end

  # Test record.
  test "record with global config" do
    Exlibris::Aleph.configure do |c|
      c.base_url = "http://aleph.library.nyu.edu"
    end
    VCR.use_cassette('record') do
      aleph_record = Exlibris::Aleph::Rest::Record.new(bib_library: @aleph_doc_library, record_id: @aleph_doc_number)
      bib = aleph_record.bib
      assert_kind_of String, bib
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling bib: #{aleph_record.error}")
      holdings = aleph_record.holdings
      assert_kind_of Array, holdings
      holdings.each { |holding| assert_kind_of Hash, holding }
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling holdings: #{aleph_record.error}")
      items = aleph_record.items
      assert_kind_of Array, items
      items.each { |item| assert_kind_of Hash, item }
      assert_nil(aleph_record.error, "Failure in #{aleph_record.class} while calling items: #{aleph_record.error}")
    end
  end
end