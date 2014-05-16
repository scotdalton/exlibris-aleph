require 'spec_helper'
module Exlibris
  module Aleph
    describe Patron, vcr: { cassette_name: 'patron' } do
      let(:id) { 'BOR_ID' }
      subject(:patron) { Patron.new(id) }
      it { should be_a Patron }
      describe '#id' do
        subject { patron.id }
        it { should eq id }
      end
      describe '#admin_library' do
        subject { patron.admin_library }
        it { should be_an AdminLibrary }
        it { should eql AdminLibrary.new('NYU50')}
      end
      describe '#address' do
        subject { patron.address }
        it { should be_an Patron::Address }
      end
      describe '#record' do
        let(:record_id) { 'NYU01000980206' }
        subject { patron.record(record_id) }
        it { should be_a Patron::Record }
      end
    end
  end
end
