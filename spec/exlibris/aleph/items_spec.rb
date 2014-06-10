require 'spec_helper'
module Exlibris
  module Aleph
    describe Items, vcr: {cassette_name: 'record', record: :new_episodes} do
      let(:record_id) { 'NYU01000864162' }
      subject(:items) { Items.new(record_id) }
      it { should be_an Items }
      describe '#record_id' do
        subject { items.record_id }
        it { should eq record_id }
      end
      describe '#each' do
        subject { items.each }
        it { should be_an Enumerable }
      end
      describe '#size' do
        subject { items.size }
        it { should eq 2 }
      end
      describe '#to_a' do
        subject { items.to_a }
        it { should be_an Array }
        it 'should contain Items' do
          subject.each do |item|
            expect(item).to be_an Item
          end
        end
      end
      context 'when there is only one item' do
        let(:record_id) { 'NYU01003415726' }
        describe '#size' do
          subject { items.size }
          it { should eq 1 }
        end
        describe '#to_a' do
          subject { items.to_a }
          it { should be_an Array }
          it 'should contain Items' do
            subject.each do |item|
              expect(item).to be_an Item
            end
          end
        end
      end
      context 'when there are no items' do
        let(:record_id) { 'NYU01000000000' }
        describe '#size' do
          subject { items.size }
          it { should eq 0 }
        end
        describe '#to_a' do
          subject { items.to_a }
          it { should be_an Array }
          it { should be_empty }
        end
      end
    end
  end
end
