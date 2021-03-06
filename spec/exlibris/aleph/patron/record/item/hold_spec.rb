require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          describe Hold, vcr: {cassette_name: 'patron'} do
            let(:patron_id) { 'BOR_ID' }
            let(:record_id) { 'NYU01000864162' }
            let(:item_id) { 'NYU50000864162000010' }
            subject(:hold) { Hold.new(patron_id, record_id, item_id) }
            describe '#patron_id' do
              subject { hold.patron_id }
              it { should eq patron_id }
            end
            describe '#record_id' do
              subject { hold.record_id }
              it { should eq record_id }
            end
            describe '#item_id' do
              subject { hold.item_id }
              it { should eq item_id }
            end
            describe '#pickup_locations' do
              subject { hold.pickup_locations }
              it { should be_an Array }
            end
            describe '#allowed?' do
              subject { hold.allowed? }
              it { should be_true }
              context 'when the patron does not have permissions place a hold on the item' do
                let(:patron_id) { 'BOR_ID_WITHOUT_HOLD_PERMISSION' }
                it { should be_false }
              end
            end
          end
        end
      end
    end
  end
end
