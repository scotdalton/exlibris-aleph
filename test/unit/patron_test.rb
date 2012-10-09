require 'test_helper'
class PatronTest < ActiveSupport::TestCase
  def setup
    @rest_url = "http://aleph.library.nyu.edu:1891/rest-dlf"
    @aleph_doc_library = "NYU01"
    @aleph_doc_number = "000062856"
    @nyuidn = "N12162279"
    @aleph_adm_library = "NYU50"
    @aleph_item_id = "NYU50000062856000010"
    @aleph_renew_item_id = "NYU50000647049"
    @pickup_location = "BOBST"
    @bogus_url = "http://library.nyu.edu/bogus"
  end

  # Test exception handling for bogus response.
  test "test_bogus_response" do
    VCR.turned_off do
      patron = Exlibris::Aleph::Patron.new(@nyuidn, @bogus_url)
      assert_raise(MultiXml::ParseError) { patron.loans }
      assert_raise(MultiXml::ParseError) { patron.renew_loans() }
      assert_raise(MultiXml::ParseError) { patron.renew_loans(@aleph_renew_item_id) }
      assert_raise(MultiXml::ParseError) { patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {:pickup_location => @pickup_location}) }
    end
  end

  # Test patron
  test "test_patron" do
    VCR.use_cassette('patron') do
      patron = Exlibris::Aleph::Patron.new(@nyuidn, @rest_url)
      loans = patron.loans
      assert_nil(patron.error, "Failure in #{patron.class} while getting loans: #{patron.error}")
      #renew_loans = patron.renew_loans()
      #assert_nil(patron.error, "Failure in #{patron.class} while renewing all loans: #{patron.error}")
      #renew_loans = patron.renew_loans(@aleph_renew_item_id)
      #assert_nil(patron.error, "Failure in #{patron.class} while renewing loan #{@aleph_renew_item_id}: #{patron.error}")
      assert_raise(RuntimeError) { patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {}) }
      place_hold = patron.place_hold(@aleph_adm_library, @aleph_doc_library, @aleph_doc_number, @aleph_item_id, {:pickup_location => @pickup_location})
      assert_nil(patron.error, "Failure in #{patron.class} while placing hold: #{patron.error}")
    end
  end
end