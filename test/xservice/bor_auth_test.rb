require 'test_helper'
class BorAuthTest < ActiveSupport::TestCase
  
  def setup
  end

  test "new" do
    VCR.use_cassette('bor auth') do
      bor_auth = 
        Exlibris::Aleph::Xservice::BorAuth.new(
          "http://aleph.library.nyu.edu", "NYU50", "BOBST", "N", 
          "BOR_ID", "VERIFICATION")
      assert_nil(bor_auth.error, "Error is not nil.")
    end
  end
  
  test "permissions" do
    VCR.use_cassette('bor auth') do
      bor_auth = 
        Exlibris::Aleph::Xservice::BorAuth.new(
          "http://aleph.library.nyu.edu", "NYU50", "BOBST", "N", 
          "BOR_ID", "VERIFICATION")
      assert_equal("51", bor_auth.permissions[:bor_status])
      assert_equal("CB", bor_auth.permissions[:bor_type])
      assert_equal("Y", bor_auth.permissions[:hold_on_shelf])
    end
  end
end