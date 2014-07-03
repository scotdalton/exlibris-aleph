require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Record
          describe Item do
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
                    'z13_isbn_issn_code' => nil,
                    'z13_isbn_issn' => nil
                  },
                  'status' => 'On Hold'
                }
              }
            end

            subject(:item) { Item.new(root) }
            it { should be_a Item }
            describe '#root' do
              subject { item.root }
              it { should eq root }
            end
            describe '#admin_library_code' do
              subject { item.admin_library_code }
              it { should eq 'NYU50' }
            end
            describe '#sub_library_code' do
              subject { item.sub_library_code }
              it { should eq 'TNSGI' }
            end
            describe '#sub_library_display' do
              subject { item.sub_library_display }
              it { should eq 'New School University Center' }
            end
            describe '#collection_code' do
              subject { item.collection_code }
              it { should eq 'SPCLP' }
            end
            describe '#collection_display' do
              subject { item.collection_display }
              it { should eq 'SpecCol Periodicals' }
            end
            describe '#status_code' do
              subject { item.status_code }
              it { should eq '04' }
            end
            describe '#status_display' do
              subject { item.status_display }
              it { should eq 'Ask at Reference' }
            end
            describe '#processing_status_code' do
              subject { item.processing_status_code }
              it { should eq 'DM' }
            end
            describe '#processing_status_display' do
              subject { item.processing_status_display }
              it { should eq 'Depository mediated' }
            end
            describe '#classification' do
              subject { item.classification }
              it { should eq 'Non-circulating' }
            end
            describe '#description' do
              subject { item.description }
              it { should eq 'no.1(1991:spring)' }
            end
            describe '#circulation_status_value' do
              subject { item.circulation_status_value }
              it { should eq 'On Hold' }
            end
            describe '#opac_note' do
              subject { item.opac_note }
              it { should eq 'Spring' }
            end
            describe '#queue' do
              subject { item.queue }
              it { should eq '1 request(s) of 1 items.' }
            end
          end
        end
      end
    end
  end
end
