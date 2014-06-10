require 'spec_helper'
module Exlibris
  module Aleph
    describe Record, vcr: {cassette_name: 'record', record: :new_episodes} do
      let(:id) { 'NYU01000864162' }
      subject(:record) { Record.new(id) }
      describe '#id' do
        subject { record.id }
        it { should eq id }
      end
      describe '#metadata' do
        subject { record.metadata }
        it { should be_a Record::Metadata }
      end
      describe '#items' do
        subject { record.items }
        it { should be_an Array }
        it { should_not be_empty }
      end
      describe '#holdings' do
        subject { record.holdings }
        it { should be_an Array }
        it { should_not be_empty }
      end
      context 'when the record does not exist' do
        let(:id) { 'NYU01000000000' }
        describe '#metadata' do
          subject { record.metadata }
          it { should be_nil }
        end
        describe '#items' do
          subject { record.items }
          it { should be_an Array }
          it { should be_empty }
        end
        describe '#holdings' do
          subject { record.holdings }
          it { should be_an Array }
          it { should be_empty }
        end
      end
    end
  end
end
