require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe CirculationStatus do
        let(:value) { "On Shelf" }
        subject(:circulation_status) { CirculationStatus.new(value) }
        it { should be_a CirculationStatus }
        describe '#value' do
          subject { circulation_status.value }
          it { should eq value }
        end
        describe '#==' do
          subject { circulation_status == other_object }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { CirculationStatus.new(value) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { CirculationStatus.new('Reshelving') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { circulation_status === other_object }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { CirculationStatus.new(value) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { CirculationStatus.new('Reshelving') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { circulation_status.eql?(other_object) }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { CirculationStatus.new(value) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { CirculationStatus.new('Reshelving') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
      end
    end
  end
end
