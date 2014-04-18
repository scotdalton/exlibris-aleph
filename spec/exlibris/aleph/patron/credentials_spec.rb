require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe Credentials do
        let(:id) { 'BOR_ID' }
        let(:verification) { 'VERIFICATION' }
        subject(:credentials) { Credentials.new(id, verification) }
        describe '#id' do
          subject { credentials.id }
          it { should eq id }
        end
        describe '#verification' do
          subject { credentials.verification }
          it { should eq verification }
        end
      end
    end
  end
end
