require 'spec_helper'
module Exlibris
  module Aleph
    describe Patron do
      let(:id) { 'BOR_ID' }
      let(:verification) { 'VERIFICATION' }
      let(:credentials) { Patron::Credentials.new('BOR_ID', 'VERIFICATION') }
      subject(:patron) { Patron.new(credentials) }
      it { should be_a Patron }
      describe '#credentials' do
        subject { patron.credentials }
        it { should eq credentials }
      end
      describe '#permissions' do
      end
      context 'when initialized with "credentials" argument' do
        context 'but the "credentials" argument is not a Patron::Credentials' do
          let(:credentials) { "invalid" }
          it 'should raise an ArgumentError' do
            expect { subject }.to raise_error ArgumentError
          end
        end
      end
    end
  end
end
