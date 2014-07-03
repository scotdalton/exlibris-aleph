require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe Status do
        let(:code) { '01' }
        let(:display) { 'Patron' }
        subject(:status) { Status.new(code, display) }
        it { should be_a Status }
        describe '#code' do
          subject { status.code }
          it { should eq code }
        end
        describe '#display' do
          subject { status.display }
          it { should eq display }
        end
        describe '#==' do
          subject { status == other_object }
          context 'when the other object is an Patron::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code, display) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('02', display) }
              it { should be_false }
            end
          end
          context 'when the other object is not an Patron::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { status === other_object }
          context 'when the other object is an Patron::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code, display) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('02', display) }
              it { should be_false }
            end
          end
          context 'when the other object is not an Patron::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { status.eql?(other_object) }
          context 'when the other object is an Patron::Status' do
            context 'and the code is the same' do
              let(:other_object) { Status.new(code, display) }
              it { should be_true }
            end
            context 'but the code is different' do
              let(:other_object) { Status.new('02', display) }
              it { should be_false }
            end
          end
          context 'when the other object is not an Patron::Status' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
      end
    end
  end
end
