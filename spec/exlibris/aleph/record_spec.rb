require 'spec_helper'
module Exlibris
  module Aleph
    describe Record, vcr: { cassette_name: 'record' } do
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
    end
  end
end
