require 'spec_helper'
module Exlibris
  module Aleph
    describe Item, vcr: {cassette_name: 'record', record: :new_episodes} do
      let(:record_id) { 'NYU01000864162' }
      let(:id) { 'NYU50000864162000010' }
      subject(:item) { Item.new(record_id, id) }
      describe '#record_id' do
        subject { item.record_id }
        it { should eq record_id }
      end
      describe '#id' do
        subject { item.id }
        it { should eq id }
      end
      describe '#collection' do
        subject { item.collection }
        it { should be_a Collection }
      end
      describe '#call_number' do
        subject { item.call_number }
        it { should be_a Item::CallNumber }
      end
      describe '#status' do
        subject { item.status }
        it { should be_a Item::Status }
      end
      describe '#processing_status' do
        subject { item.processing_status }
        it { should be_a Item::ProcessingStatus }
      end
      describe '#circulation_status' do
        subject { item.circulation_status }
        it { should be_a Item::CirculationStatus }
      end
      describe '#on_shelf?' do
        subject { item.on_shelf? }
        it { should be_true }
        context 'when the circulation status is "Reshelving"' do
          let(:id) { 'NYU50000864162000020' }
          it { should be_false }
        end
      end
      describe '#circulation_policy' do
        subject { item.circulation_policy }
        it { should be_an Item::CirculationPolicy }
      end
      context 'when the item does not exist' do
        let(:id) { 'ADM50' }
        describe '#collection' do
          subject { item.collection }
          it { should be_nil }
        end
        describe '#call_number' do
          subject { item.call_number }
          it { should be_nil }
        end
        describe '#status' do
          subject { item.status }
          it { should be_nil }
        end
        describe '#processing_status' do
          subject { item.processing_status }
          it { should be_nil }
        end
        describe '#circulation_status' do
          subject { item.circulation_status }
          it { should be_nil }
        end
        describe '#on_shelf?' do
          subject { item.on_shelf? }
          it { should be_false }
        end
        describe '#circulation_policy' do
          subject { item.circulation_policy }
          it { should be_nil }
        end
      end
    end
  end
end
