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
      end
    end
  end
end
