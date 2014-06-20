require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        describe Item, vcr: {cassette_name: 'patron'} do
          let(:patron_id) { 'BOR_ID' }
          let(:record_id) { 'NYU01000980206' }
          let(:id) { 'NYU50001951476001220' }
          subject(:item) { Item.new(patron_id, record_id, id) }
          it { should be_an Item }
          describe '#patron_id' do
            subject { item.patron_id }
            it { should eq patron_id }
          end
          describe '#record_id' do
            subject { item.record_id }
            it { should eq record_id }
          end
          describe '#id' do
            subject { item.id }
            it { should eq id }
          end
          describe '#item' do
            subject { item.item }
            it { should be_an Aleph::Item }
          end
          describe '#circulation_policy' do
            subject { item.circulation_policy }
            it { should be_an Item::CirculationPolicy }
            it 'should have an empty Array of pickup locations' do
              expect(subject.pickup_locations).to be_an Array
              expect(subject.pickup_locations).to be_empty
            end
            context 'when the circulation policy has pickup locations' do
              let(:record_id) { 'NYU01000864162' }
              let(:id) { 'NYU50000864162000010' }
              it 'should have a non-empty Array of pickup locations' do
                expect(subject.pickup_locations).to be_an Array
                expect(subject.pickup_locations).not_to be_empty
              end
            end
          end
          describe '#hold' do
            let(:record_id) { 'NYU01000864162' }
            let(:id) { 'NYU50000864162000010' }
            subject { item.hold }
            it { should be_an Item::Hold }
          end
          describe '#create_hold' do
            let(:record_id) { 'NYU01002296594' }
            let(:id) { 'NYU50002296594000010' }
            let(:pickup_location) do
              Exlibris::Aleph::PickupLocation.new('BOBST', 'NYU Bobst')
            end
            let(:parameters) { {pickup_location: pickup_location} }
            subject { item.create_hold(parameters) }
            it { should be_an Item::CreateHold }
          end
        end
      end
    end
  end
end
