require 'test_helper'
class TabHelperTest < ActiveSupport::TestCase
  def setup
    @adms = ["NYU50", "NYU51"]
    @tab_path = "#{File.dirname(__FILE__)}/mnt/aleph_tab"
    @yml_path = File.join(File.dirname(__FILE__), "config/aleph")
    Exlibris::Aleph.configure { |c|
      c.adms = @adms
      c.tab_path = @tab_path
      c.yml_path = @yml_path
    }
    @helper = Exlibris::Aleph::TabHelper.instance
  end

  test "configure" do
    assert_equal(["nyu50", "nyu51"], @helper.adms)
    assert_equal(File.join(File.dirname(__FILE__), "mnt/aleph_tab"), @helper.class.tab_path)
    assert_equal(File.join(File.dirname(__FILE__), "config/aleph"), @helper.class.yml_path)
  end

  test "instance" do
    assert_nothing_raised() { Exlibris::Aleph::TabHelper.send(:new) }
    assert_same(@helper, Exlibris::Aleph::TabHelper.instance)
  end

  test "refresh" do
    @helper.instance_variable_set(:@refresh_time, lambda{1.second.ago})
    @helper.sub_libraries
    updated_at_1 = @helper.updated_at
    @helper.sub_libraries
    updated_at_2 = @helper.updated_at
    assert_equal(updated_at_1, updated_at_2)
    sleep 1
    @helper.sub_libraries
    assert_not_equal(updated_at_1, @helper.updated_at)
    @helper.instance_variable_set(:@refresh_time, @helper.class.refresh_time)
  end

  test "successful refresh?" do
    @helper.send(:refresh)
    assert @helper.send(:successful_refresh?)
    @helper.instance_variable_get(:@patrons)["nyu50"] = false
    assert((not @helper.send(:successful_refresh?)))
    @helper.send(:refresh)
    assert @helper.send(:successful_refresh?)
  end

  test "sub_library_text" do
    assert_equal("NYU Bobst", @helper.sub_library_text("BOBST"))
  end

  test "sub_library_adm" do
    assert_equal("NYU50", @helper.sub_library_adm("BOBST"))
  end

  test "item_pickup_locations" do
    assert_equal(
      ["BOBST", "NCOUR", "NIFA", "NISAW", "NREI", "NPOLY", "NYUAB", "NYUSE", "NYUSS"],
      @helper.item_pickup_locations({:adm_library_code => "nyu50", :sub_library_code => "BOBST", :bor_status => "51"}))
  end

  test "collection_text" do
    assert_equal(
      "Main Collection",
      @helper.collection_text({:adm_library_code => "nyu50", :sub_library_code => "BOBST", :collection_code => "MAIN"}))
  end

  test "item_web_text" do
    assert_equal(
      "Offsite Available",
      @helper.item_web_text({:adm_library_code => "nyu50", :item_process_status => "Depository"}))
    assert_equal(
      "Offsite Available",
      @helper.item_web_text({:adm_library_code => "nyu50", :sub_library_code => "BOBST", :item_process_status_code => "DP"}))
  end

  test "item_permissions" do
    assert_equal("C", @helper.item_permissions(:adm_library_code => "nyu50",
      :sub_library_code => "BOBST", :item_status_code => "01", :item_process_status_code => "DP")[:hold_request])
  end

  test "sub_libraries" do
    assert_equal("BOBST", @helper.sub_libraries["BOBST"][:code])
    assert_equal("NYU Bobst", @helper.sub_libraries["BOBST"][:text])
    assert_equal("NYU50", @helper.sub_libraries["BOBST"][:library])
  end

  test "patrons" do
    assert_equal("51", @helper.patrons["nyu50"]["51"][:code])
    assert_equal("NYU Administrator", @helper.patrons["nyu50"]["51"][:text])
  end

  test "patron_permissions" do
    assert_equal("BOBST", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:sub_library])
    assert_equal("51", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:patron_status])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:loan_permission])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:photo_permission])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:override_permission])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:multiple_hold_permission])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:check_loan])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:hold_permission])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:renew_permission])
    assert_equal("Y", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:hold_request_permission_for_item_on_shelf])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:loan_display])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:reading_room_permission])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:item_booking_permission])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:booking_ignore_closing_hours])
    assert_equal("N", @helper.patron_permissions["nyu50"]["BOBST"]["51"][:automatically_create_aleph_record])
  end

  test "items" do
    assert_equal("ITEM-STATUS", @helper.items["nyu50"]["Billed as lost"][:code])
    assert_equal("Billed as lost", @helper.items["nyu50"]["Billed as lost"][:original_text])
    assert_equal("Request ILL", @helper.items["nyu50"]["Billed as lost"][:web_text])
  end

  test "item_permissions_by_item_status" do
    assert_equal("BOBST", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:sub_library])
    assert_equal("01", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:item_status])
    assert_equal("Regular loan", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:text])
    assert_equal("Y", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:loan])
    assert_equal("Y", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:renew])
    assert_equal("Y", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:hold_request])
    assert_equal("N", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:photocopy_request])
    assert_equal("Y", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:web_opac])
    assert_equal("N", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:specific_item])
    assert_equal("N", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:limit_hold])
    assert_equal("Y", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:recall])
    assert_equal("N", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:rush_recall])
    assert_equal("N", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:booking_permission])
    assert_equal("00", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:reloaning_limit])
    assert_equal("A", @helper.item_permissions_by_item_status["nyu50"]["BOBST"]["01"][:booking_hours])
  end

  test "item_permissions_by_item_process_status" do
    assert_equal("BOBST", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:sub_library])
    assert_equal("AC", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:item_process_status])
    assert_equal("AFC-Post cataloging", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:text])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:loan])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:renew])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:hold_request])
    assert_equal("N", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:photocopy_request])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:web_opac])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:specific_item])
    assert_equal("N", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:limit_hold])
    assert_equal("Y", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:recall])
    assert_equal("N", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:rush_recall])
    assert_equal("N", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:booking_permission])
    assert_equal("00", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:reloaning_limit])
    assert_equal("A", @helper.item_permissions_by_item_process_status["nyu50"]["BOBST"]["AC"][:booking_hours])
  end

  test "collections" do
    assert_equal("BOBST", @helper.collections["nyu50"]["BOBST"]["MAIN"][:sub_library])
    assert_equal("MAIN", @helper.collections["nyu50"]["BOBST"]["MAIN"][:collection_code])
    assert_equal("Main Collection", @helper.collections["nyu50"]["BOBST"]["MAIN"][:text])
  end

  test "pickup_locations" do
    assert_equal("BOBST", @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:sub_library])
    assert_equal("##", @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:item_status])
    assert_equal("DP", @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:item_process_status])
    assert_equal("51", @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:patron_status])
    assert_equal("Y", @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:availability_status])
    assert_equal(["BOBST", "NCOUR", "NIFA", "NISAW", "NREI", "NPOLY", "NYUAB", "NYUSE", "NYUSS"], @helper.pickup_locations["nyu50"]["BOBST"]["##"]["DP"]["51"]["Y"][:pickup_locations])
  end

  test "pickup_locations on multiple lines" do
    assert_equal(["BOBST", "NCOUR", "NIFA","NISAW","NREI","NPOLY","NYUAB","NBERL",
      "NFLOR","NLOND","NPRAG","NWADC"], @helper.pickup_locations["nyu50"]["BOBST"]["##"]["##"]["89"]["#"][:pickup_locations])
  end

  test "refresh_yml" do
    assert_nil(@helper.sub_libraries["NEW__"])
    sub_library_file = "#{File.dirname(__FILE__)}/mnt/aleph_tab/alephe/tab/tab_sub_library.eng"
    file = File.open(sub_library_file, 'r')
    old_size = File.size(sub_library_file)
    file.close
    # Update the file.
    File.open(sub_library_file, 'a') {|f| f.puts "NEW__ 1 NYU50 L NYU TEST                       BOBST BOBST BOBST BOBST NYU50 ALEPH" }
    Exlibris::Aleph::TabHelper.refresh_yml
    @helper.send(:refresh)
    assert_not_nil(@helper.sub_libraries["NEW__"])
    assert_equal("NEW__", @helper.sub_libraries["NEW__"][:code])
    assert_equal("NYU TEST", @helper.sub_libraries["NEW__"][:text])
    assert_equal("NYU50", @helper.sub_libraries["NEW__"][:library])
    # Revert the file to what it was
    file = File.open(sub_library_file, 'r+')
    file.truncate(old_size)
    file.close
  end
end