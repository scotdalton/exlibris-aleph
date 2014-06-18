require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          class Record
            describe Item do
              let(:pickup_locations) { nil }
              let(:root) do
                {
                  'reply_text' => 'ok',
                  'reply_code' => '0000',
                  'item' => {
                    'z30_sub_library_code' => 'TNSGI',
                    'z30_item_process_status_code' => 'DM',
                    'z30_item_status_code' => '04',
                    'z30_collection_code' => 'SPCLP',
                    'queue' => '1 request(s) of 1 items.',
                    'z30' => {
                      'translate_change_active_library' => 'NYU50',
                      'z30_doc_number' => '001951476',
                      'z30_item_sequence' => '  122.0',
                      'z30_barcode' => '31207026692263',
                      'z30_sub_library' => 'New School University Center',
                      'z30_material' => 'Issue (bound)',
                      'z30_item_status' => 'Ask at Reference',
                      'z30_open_date' => '20110510',
                      'z30_update_date' => '20140317',
                      'z30_cataloger' => 'LOORC',
                      'z30_date_last_return' => '20140206',
                      'z30_hour_last_return' => '1151',
                      'z30_ip_last_return' => '149.31.214.133',
                      'z30_no_loans' => '001',
                      'z30_alpha' => 'L',
                      'z30_collection' => 'SpecCol Periodicals',
                      'z30_call_no_type' => nil,
                      'z30_call_no' => 'Non-circulating',
                      'z30_call_no_key' => '$$mnon-circulating',
                      'z30_call_no_2_type' => nil,
                      'z30_call_no_2' => nil,
                      'z30_call_no_2_key' => nil,
                      'z30_description' => 'no.1(1991:spring)',
                      'z30_note_opac' => 'Spring',
                      'z30_note_circulation' => nil,
                      'z30_note_internal' => 'Numbered limited edition /1000.',
                      'z30_order_number' => nil,
                      'z30_inventory_number' => nil,
                      'z30_inventory_number_date' => '00000000',
                      'z30_last_shelf_report_date' => '00000000',
                      'z30_price' => nil, 'z30_shelf_report_number' => nil,
                      'z30_on_shelf_date' => '00000000',
                      'z30_on_shelf_seq' => '000000',
                      'z30_doc_number_2' => '000000000',
                      'z30_schedule_sequence_2' => '00000',
                      'z30_copy_sequence_2' => '00000',
                      'z30_vendor_code' => nil,
                      'z30_invoice_number' => nil,
                      'z30_line_number' => '00000',
                      'z30_pages' => nil,
                      'z30_issue_date' => '20110510',
                      'z30_expected_arrival_date' => '20110510',
                      'z30_arrival_date' => '20110510',
                      'z30_item_statistic' => nil,
                      'z30_item_process_status' => 'Depository mediated',
                      'z30_copy_id' => nil,
                      'z30_hol_doc_number' => '000036718',
                      'z30_temp_location' => 'No',
                      'z30_enumeration_a' => '1',
                      'z30_enumeration_b' => nil,
                      'z30_enumeration_c' => nil,
                      'z30_enumeration_d' => nil,
                      'z30_enumeration_e' => nil,
                      'z30_enumeration_f' => nil,
                      'z30_enumeration_g' => nil,
                      'z30_enumeration_h' => nil,
                      'z30_chronological_i' => '1991',
                      'z30_chronological_j' => '21',
                      'z30_chronological_k' => nil,
                      'z30_chronological_l' => nil,
                      'z30_chronological_m' => nil,
                      'z30_supp_index_o' => nil,
                      'z30_85x_type' => '3',
                      'z30_depository_id' => 'TNSRS',
                      'z30_linking_number' => '000000001',
                      'z30_gap_indicator' => nil,
                      'z30_maintenance_count' => '000',
                      'z30_process_status_date' => '20140317'
                    },
                    'z13' => {
                      'translate_change_active_library' => 'NYU50',
                      'z13_doc_number' => '001951476',
                      'z13_year' => '1991',
                      'z13_open_date' => '20080618',
                      'z13_update_date' => '20140328',
                      'z13_call_no_key' => nil,
                      'z13_call_no_code' => 'LOC',
                      'z13_call_no' => nil,
                      'z13_author_code' => nil,
                      'z13_author' => nil,
                      'z13_title_code' => '24500',
                      'z13_title' => 'Visionaire.',
                      'z13_imprint_code' => '260',
                      'z13_imprint' => '[New York] : Visionaire Publishing, c1991-',
                      'z13_isbn_issn_code' => nil, 'z13_isbn_issn' => nil
                    },
                    'status' => 'On Hold',
                    'info' => [
                      {
                        'note' => {
                          '__content__' => 'Item cannot be requested (tab15).',
                          'type' => 'error'
                        },
                        'type' => 'HoldRequest',
                        'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/items/NYU50001951476001220/hold',
                        'allowed' => 'N'
                      },
                      {
                        'note' => {
                          '__content__' => 'The item has no short loan schedule',
                          'type' => 'error'
                        },
                        'type' => 'ShortLoan',
                        'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/items/NYU50001951476001220/shortLoan',
                        'allowed' => 'N'
                      },
                      {
                        'note' => {
                          '__content__' => 'Item cannot be photocopied (tab15).',
                          'type' => 'error'
                        },
                        'adm_library' => 'NYU50',
                        'adm_doc_number' => '001951476',
                        'item_sequence' => '001220',
                        'type' => 'PhotocopyRequest',
                        'allowed' => 'N'
                      },
                      {
                        'note' => {
                          '__content__' => 'Item cannot be booked (tab15).',
                          'type' => 'error'
                        },
                        'adm_library' => 'NYU50',
                        'adm_doc_number' => '001951476',
                        'item_sequence' => '001220',
                        'exact_item' => 'Y',
                        'type' => 'BookingRequest',
                        'allowed' => 'N'
                      }
                    ]
                  }
                }
              end
              let(:info) { root['item']['info'] }
              before do
                info.first['hold'] = { 'pickup_locations' => pickup_locations }
              end
              subject(:item) { Item.new(root) }
              it { should be_a Item }
              describe '#root' do
                subject { item.root }
                it { should eq root }
              end
              describe '#pickup_locations' do
                subject { item.pickup_locations }
                it { should be_an Array }
                context 'when pickup locations is nil' do
                  let(:pickup_locations) { nil }
                  it { should be_an Array }
                  it { should be_empty }
                end
                context 'when there are no pickup locations' do
                  let(:pickup_locations) { {'usage' => 'Mandatory'} }
                  it { should be_an Array }
                  it { should be_empty }
                end
                context 'when there is only one pickup location' do
                  let(:pickup_locations) do
                    {
                      'pickup_location' => {
                        '__content__' => 'NYU Bobst',
                        'code' => 'BOBST'
                      },
                      'default' => 'Y',
                      'usage' => 'Mandatory'
                    }
                  end
                  it { should be_an Array }
                  it { should_not be_empty }
                end
                context 'when the item has multiple pickup locations' do
                  let(:pickup_locations) do
                    {
                      'pickup_location' => [
                        {
                          '__content__' => 'NYU Bobst',
                          'code' => 'BOBST'
                        },
                        {
                          '__content__' => 'NYU Courant',
                          'code' => 'NCOUR'
                        },
                        {
                          '__content__' => 'NYU Institute of Fine Arts',
                          'code' => 'NIFA'
                        },
                        {
                          '__content__' => 'NYU Inst Study Ancient World',
                          'code' => 'NISAW'
                        },
                        {
                          '__content__' => 'NYU Jack Brause',
                          'code' => 'NREI'
                        },
                        {
                          '__content__' => 'NYU Poly',
                          'code' => 'NPOLY'
                        },
                        {
                          '__content__' => 'NYU Abu Dhabi Library (UAE)',
                          'code' => 'NYUAB'
                        },
                        {
                          '__content__' => 'NYUAD Ctr for Sci & Eng (UAE)',
                          'code' => 'NYUSE'
                        },
                        {
                          '__content__' => 'NYUAD Sama Fac Offices (UAE)',
                          'code' => 'NYUSS'
                        },
                        {
                          '__content__' => 'NYU Shanghai Library (China)',
                          'code' => 'NYUSX'
                        }
                      ],
                      'default' => 'Y',
                      'usage' => 'Mandatory'
                    }
                  end
                  it { should be_an Array }
                  it { should_not be_empty }
                end
              end
              describe '#hold_request' do
                subject { item.hold_request }
                it { should eq 'N' }
              end
              describe '#short_loan' do
                subject { item.short_loan }
                it { should eq 'N' }
              end
              describe '#photocopy_request' do
                subject { item.photocopy_request }
                it { should eq 'N' }
              end
              describe '#booking_request' do
                subject { item.booking_request }
                it { should eq 'N' }
              end
            end
          end
        end
      end
    end
  end
end
