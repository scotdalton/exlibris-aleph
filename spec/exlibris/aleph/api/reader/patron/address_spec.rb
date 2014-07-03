require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          describe Address do
            let(:root) do 
              {
                'address_information' => {
                  'z304_address_1' => {
                    '__content__' => 'SURNAME,GIVEN NAME',
                    'usage' => 'Mandatory',
                    'max_len' => '50'
                  },
                  'z304_address_2' => {
                    '__content__' => '123 ADDRESS, #APT',
                    'usage' => 'Optional',
                    'max_len' => '50'
                  },
                  'z304_address_3' => {
                    '__content__' => 'BROOKLYN',
                    'usage' => 'Optional',
                    'max_len' => '50'
                  },
                  'z304_address_4' => {
                    '__content__' => 'NY',
                    'usage' => 'Optional',
                    'max_len' => '50'
                  },
                 'z304_address_5' => {
                   '__content__' => 'NY',
                   'usage' => 'Optional',
                   'max_len' => '50'
                  },
                  'z304_date_from' => {
                    '__content__' => '20140211',
                    'usage' => 'Mandatory'
                  },
                  'z304_date_to' => {
                    '__content__' => '20200101',
                    'usage' => 'Mandatory'
                  },
                  'z304_zip' => {
                    '__content__' => '11215',
                    'usage' => 'Optional',
                    'max_len' => '9'
                  },
                  'z304_telephone_1' => {
                    'usage' => 'Optional',
                    'max_len' => '30'
                  },
                  'z304_telephone_2' => {
                    'usage' => 'Optional',
                    'max_len' => '30'
                  },
                  'z304_telephone_3' => {
                    'usage' => 'Optional',
                    'max_len' => '30'
                  },
                  'z304_telephone_4' => {
                    'usage' => 'Optional',
                    'max_len' => '30'
                  },
                  'z304_sms_number' => {
                    'usage' => 'Optional',
                    'max_len' => '30'
                  },
                  'z303_want_sms' => {
                    '__content__' => 'N',
                    'usage' => 'Optional'
                  },
                  'z303_plain_html' => {
                    '__content__' => 'Email Body Only',
                    'usage' => 'Optional',
                    'code' => 'P'
                  },
                  'z304_email_address' => {
                    '__content__' => 'bor_id@library.nyu.edu',
                    'usage' => 'Optional',
                    'max_len' => '60'
                  },
                  'updateable' => 'Y'
                }
              }
            end

            subject(:address) { Address.new(root) }
            it { should be_a Address }
            describe '#root' do
              subject { address.root }
              it { should eq root }
            end
            describe '#address1' do
              subject { address.address1 }
              it { should eql 'SURNAME,GIVEN NAME'}
            end
            describe '#address2' do
              subject { address.address2 }
              it { should eql '123 ADDRESS, #APT'}
            end
            describe '#address3' do
              subject { address.address3 }
              it { should eql 'BROOKLYN'}
            end
            describe '#address4' do
              subject { address.address4 }
              it { should eql 'NY'}
            end
            describe '#address5' do
              subject { address.address5 }
              it { should eql 'NY'}
            end
            describe '#telephone1' do
              subject { address.telephone1 }
              it { should be_nil }
            end
            describe '#telephone2' do
              subject { address.telephone2 }
              it { should be_nil }
            end
            describe '#telephone3' do
              subject { address.telephone3 }
              it { should be_nil }
            end
            describe '#telephone4' do
              subject { address.telephone4 }
              it { should be_nil }
            end
            describe '#zip' do
              subject { address.zip }
              it { should eq '11215' }
            end
            describe '#sms_number' do
              subject { address.sms_number }
              it { should be_nil }
            end
            describe '#want_sms' do
              subject { address.want_sms }
              it { should eq 'N' }
            end
            describe '#email' do
              subject { address.email }
              it { should eq 'bor_id@library.nyu.edu' }
            end
          end
        end
      end
    end
  end
end
