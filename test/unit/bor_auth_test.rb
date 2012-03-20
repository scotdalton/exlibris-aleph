require 'test_helper'
class BorAuthTest < ActiveSupport::TestCase
  
  def setup
  end

  test "new" do
    bor_auth = 
      ExlibrisAleph::BorAuth.new(
        "http://aleph.library.nyu.edu", "NYU50", "BOBST", "N", 
        "N12162279", "d4465aacaa645f2164908cd4184c09f0")
    assert_nil(bor_auth.error, "Error is not nil.")
  end
  
  test "permissions" do
    bor_auth = 
      ExlibrisAleph::BorAuth.new(
        "http://aleph.library.nyu.edu", "NYU50", "BOBST", "N", 
        "N12162279", "d4465aacaa645f2164908cd4184c09f0")
    assert_equal("55", bor_auth.permissions[:bor_status])
    assert_equal("CB", bor_auth.permissions[:bor_type])
    assert_equal("N", bor_auth.permissions[:hold_on_shelf])
  end
end