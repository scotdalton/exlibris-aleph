require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      describe Status do
        let(:code) { '##' }
        subject(:status) { Status.new(code) }
        it { should be_a Status }
        describe '#code' do
          subject { status.code }
          it { should eq code }
        end
        describe '#==' do
          subject { status == other_object }
          context 'when the other object is an Item::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('01') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { status === other_object }
          context 'when the other object is an Item::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('01') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { status.eql?(other_object) }
          context 'when the other object is an Item::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('01') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Item::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
      end
    end
  end
end
