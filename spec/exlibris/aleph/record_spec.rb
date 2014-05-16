require 'spec_helper'
module Exlibris
  module Aleph
    describe Record, vcr: { cassette_name: 'record' } do
      let(:id) { '000864162' }
      let(:admin_library) { AdminLibrary.new('NYU01') }
      subject(:record) { Record.new(id, admin_library) }
      describe '#id' do
        subject { record.id }
        it { should eq id }
      end
      describe '#admin_library' do
        subject { record.admin_library }
        it { should eq admin_library }
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
