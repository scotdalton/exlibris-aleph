require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe GenericStatus do
        subject(:status) { GenericStatus.new }
        it { should be_a Status }
        it { should be_a GenericStatus }
        describe '#code' do
          subject { status.code }
          it { should eq '##' }
        end
        describe '#display' do
          subject { status.display }
          it { should eq 'Generic Status' }
        end
      end
    end
  end
end
