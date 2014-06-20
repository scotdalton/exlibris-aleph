require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          describe CreateHold, vcr: {cassette_name: 'patron'} do
            let(:patron_id) { 'BOR_ID' }
            let(:record_id) { 'NYU01002296594' }
            let(:item_id) { 'NYU50002296594000010' }
            let(:pickup_location) do
              Exlibris::Aleph::PickupLocation.new('BOBST', 'NYU Bobst')
            end
            let(:parameters) { {pickup_location: pickup_location} }
            subject(:create_hold) { CreateHold.new(patron_id, record_id, item_id, parameters) }
            describe '#patron_id' do
              subject { create_hold.patron_id }
              it { should eq patron_id }
            end
            describe '#record_id' do
              subject { create_hold.record_id }
              it { should eq record_id }
            end
            describe '#item_id' do
              subject { create_hold.item_id }
              it { should eq item_id }
            end
            describe '#note' do
              subject { create_hold.note }
              it { should eq 'Action Succeeded' }
              context 'when the patron does not have permissions place a hold on the item' do
                let(:patron_id) { 'BOR_ID_WITHOUT_HOLD_PERMISSION' }
                it { should eq 'Item or like copy is on shelf. Cannot place hold request.' }
              end
            end
            describe '#error?' do
              subject { create_hold.error? }
              it { should be_false }
              context 'when the patron does not have permissions place a hold on the item' do
                let(:patron_id) { 'BOR_ID_WITHOUT_HOLD_PERMISSION' }
                it { should be_true }
              end
            end
          end
        end
      end
    end
  end
end
