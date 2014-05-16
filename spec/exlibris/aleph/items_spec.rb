require 'spec_helper'
module Exlibris
  module Aleph
    describe Items, vcr: { cassette_name: 'record', record: :new_episodes } do
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
  end
end
