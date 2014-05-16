require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe Address, vcr: { cassette_name: 'patron', record: :new_episodes } do
        let(:patron_id) { 'BOR_ID' }
        subject(:address) { Address.new(patron_id) }
        it { should be_an Address }
        describe '#patron_id' do
          subject { address.patron_id }
          it { should eq patron_id }
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
