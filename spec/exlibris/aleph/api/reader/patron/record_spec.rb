require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          describe Record do
            let(:root) do 
              { 
                'record' => {
                  'info' => [
                    {
                      'type' => 'Items',
                      'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/items'
                    },
                    {
                      'note' => {
                        '__content__' => 'Unable to create title level request. No available items associated with record.',
                        'type' => 'error'
                      },
                      'type' => 'HoldRequest',
                      'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/holds',
                      'allowed' => 'N'
                    }, 
                    {
                      'note' => {
                        '__content__' => 'This record does not have holdings which can be booked', 
                        'type' => "error"
                      },
                      'type' => 'ShortLoan',
                      'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/shortLoan',
                      'allowed' => 'N'
                    },
                    {
                      'note' => {
                        '__content__' => 'Patron does not have a valid ILL Unit',
                        'type' => 'error'
                      },
                      'type' => 'ILL',
                      'href' => 'http://aleph.library.nyu.edu:1891/rest-dlf/patron/BOR_ID/record/NYU01000980206/ill',
                      'allowed' => 'N'
                    },
                    {
                      'bib_library' => 'NYU01',
                      'bib_doc_number' => '000980206',
                      'note' => {
                        '__content__' => 'This record does not have holdings which can be booked',
                        "type" => "error"
                      }, 'type' => 'BookingRequest',
                      'allowed' => 'N'
                    },
                    {
                      'bib_library' => 'NYU01',
                      'bib_doc_number' => '000980206',
                      'note' => {
                        '__content__' => 'You are not permitted to use this function.',
                        'type' => 'error'
                      },
                      'type' => 'AcquisitionRequest',
                      'allowed' => 'N'
                    }
                  ]
                }
              }
            end

            subject(:record) { Record.new(root) }
            it { should be_a Record }
            describe '#root' do
              subject { record.root }
              it { should eq root }
            end
            describe '#hold_request' do
              subject { record.hold_request }
              it { should eq 'N' }
            end
            describe '#short_loan' do
              subject { record.short_loan }
              it { should eq 'N' }
            end
            describe '#ill' do
              subject { record.ill }
              it { should eq 'N' }
            end
            describe '#booking_request' do
              subject { record.booking_request }
              it { should eq 'N' }
            end
            describe '#acquisition_request' do
              subject { record.acquisition_request }
              it { should eq 'N' }
            end
          end
        end
      end
    end
  end
end
