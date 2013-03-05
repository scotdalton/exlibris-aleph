require 'test_helper'
class PatronTest < ActiveSupport::TestCase
  setup do
    @rest_url = "http://aleph.library.nyu.edu:1891/rest-dlf"
    @aleph_doc_library = "NYU01"
    @aleph_doc_number = "000062856"
    @nyuidn = "BOR_ID"
    @aleph_adm_library = "NYU50"
    @aleph_item_id = "NYU50000062856000010"
    @aleph_renew_item_id = "NYU50003034208"
    @pickup_location = "BOBST"
    @bogus_url = "http://library.nyu.edu/bogus"
  end

  # Test exception handling for bogus response.
  test "test_bogus_response" do
    VCR.use_cassette('patron bogus url') do
      patron = Exlibris::Aleph::Rest::Patron.new(patron_id: @nyuidn, rest_url: @bogus_url)
      assert_raise(MultiXml::ParseError) { patron.loans }
      assert_raise(MultiXml::ParseError) { patron.renew_loans() }
      assert_raise(MultiXml::ParseError) { patron.renew_loans(@aleph_renew_item_id) }
      assert_raise(MultiXml::ParseError) { patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {:pickup_location => @pickup_location}) }
    end
  end

  # Test patron
  test "test_patron" do
    VCR.use_cassette('patron') do
      patron = Exlibris::Aleph::Rest::Patron.new(patron_id: @nyuidn, rest_url: @rest_url)
      loans = patron.loans
      assert_kind_of Array, loans
      assert((not loans.empty?), "Loans empty.")
      loans.each { |loan| assert_kind_of Hash, loan }
      assert_nil(patron.error, "Failure in #{patron.class} while getting loans: #{patron.error}")
      renew_all_loans = patron.renew_loans()
      assert_kind_of Array, renew_all_loans
      assert((not renew_all_loans.empty?), "Renew all loans empty.")
      renew_all_loans.each { |renew_all_loan| assert_kind_of Hash, renew_all_loan }
      assert_nil(patron.error, "Failure in #{patron.class} while renewing all loans: #{patron.error}")
      renew_loans = patron.renew_loans(@aleph_renew_item_id)
      assert_kind_of Array, renew_loans
      assert((not renew_loans.empty?), "Renew loans empty.")
      renew_loans.each { |renew_loan| assert_kind_of Hash, renew_loan }
      assert_nil(patron.error, "Failure in #{patron.class} while renewing loan #{@aleph_renew_item_id}: #{patron.error}")
      place_hold = patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {:pickup_location => @pickup_location})
      assert_kind_of Hash, place_hold
      assert_nil(patron.error, "Failure in #{patron.class} while placing hold: #{patron.error}")
    end
  end

  # Test patron
  test "test patron address" do
    VCR.use_cassette('patron address') do
      patron = Exlibris::Aleph::Rest::Patron.new(patron_id: @nyuidn, rest_url: @rest_url)
      address = patron.address
      assert_kind_of Hash, address
      assert_nil(patron.error, "Failure in #{patron.class} while getting address: #{patron.error}")
    end
  end

  # Test patron
  test "test patron error" do
    VCR.use_cassette('patron error') do
      patron = Exlibris::Aleph::Rest::Patron.new(patron_id: @nyuidn, rest_url: @rest_url)
      assert_raise(RuntimeError) { patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {}) }
      assert_raise(RuntimeError) { patron.renew_loans() }
      assert_raise(RuntimeError) { patron.renew_loans(@aleph_renew_item_id) }
    end
  end

  # Test patron with URL set via config
  test "test patron with global config" do
    Exlibris::Aleph.configure do |c|
      c.base_url = "http://aleph.library.nyu.edu"
    end
    VCR.use_cassette('patron') do
      patron = Exlibris::Aleph::Rest::Patron.new(patron_id: @nyuidn)
      loans = patron.loans
      assert_kind_of Array, loans
      assert((not loans.empty?), "Loans empty.")
      loans.each { |loan| assert_kind_of Hash, loan }
      assert_nil(patron.error, "Failure in #{patron.class} while getting loans: #{patron.error}")
      renew_all_loans = patron.renew_loans()
      assert_kind_of Array, renew_all_loans
      assert((not renew_all_loans.empty?), "Renew all loans empty.")
      renew_all_loans.each { |renew_all_loan| assert_kind_of Hash, renew_all_loan }
      assert_nil(patron.error, "Failure in #{patron.class} while renewing all loans: #{patron.error}")
      renew_loans = patron.renew_loans(@aleph_renew_item_id)
      assert_kind_of Array, renew_loans
      assert((not renew_loans.empty?), "Renew loans empty.")
      renew_loans.each { |renew_loan| assert_kind_of Hash, renew_loan }
      assert_nil(patron.error, "Failure in #{patron.class} while renewing loan #{@aleph_renew_item_id}: #{patron.error}")
      place_hold = patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {:pickup_location => @pickup_location})
      assert_kind_of Hash, place_hold
      assert_nil(patron.error, "Failure in #{patron.class} while placing hold: #{patron.error}")
    end
  end
end