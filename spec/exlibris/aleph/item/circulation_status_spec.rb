require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe CirculationStatus do
        let(:value) { 'On Shelf' }
        subject(:circulation_status) { CirculationStatus.new(value) }
        it { should be_a CirculationStatus }
        describe '#value' do
          subject { circulation_status.value }
          it { should eq value }
        end
        describe '#due_date' do
          subject { circulation_status.due_date }
          it { should be_nil }
          context 'when the value is "05/31/14"' do
            let(:value) { '05/31/14' }
            it { should eq '05/31/14' }
          end
          context 'when the value is "Recalled due date: 05/31/14"' do
            let(:value) { 'Recalled due date: 05/31/14' }
            it { should eq '05/31/14' }
          end
        end
        describe '#to_s' do
          subject { circulation_status.to_s }
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
