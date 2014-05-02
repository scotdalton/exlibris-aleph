require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe ProcessingStatus do
        let(:code) { 'DP' }
        subject(:processing_status) { ProcessingStatus.new(code) }
        it { should be_a ProcessingStatus }
        describe '#code' do
          subject { processing_status.code }
          it { should eq code }
        end
        describe '#display' do
          subject { processing_status.display }
          it { should be_nil }
        end
        describe '#==' do
          subject { processing_status == other_object }
          context 'when the other object is an Item::ProcessingStatus' do
            context 'and the code is the same' do
              let(:other_object) { ProcessingStatus.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { ProcessingStatus.new('##') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::ProcessingStatus' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { processing_status === other_object }
          context 'when the other object is an Item::ProcessingStatus' do
            context 'and the code is the same' do
              let(:other_object) { ProcessingStatus.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { ProcessingStatus.new('##') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::ProcessingStatus' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { processing_status.eql?(other_object) }
          context 'when the other object is an Item::ProcessingStatus' do
            context 'and the code is the same' do
              let(:other_object) { ProcessingStatus.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { ProcessingStatus.new('##') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::ProcessingStatus' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
      end
    end
  end
end
