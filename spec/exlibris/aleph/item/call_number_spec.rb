require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe CallNumber do
        let(:classification) { }
        let(:description) { }
        subject(:call_number) { CallNumber.new(classification, description) }
        describe '#classification' do
          subject { call_number.classification }
          it { should eq classification }
        end
        describe '#description' do
          subject { call_number.description }
          it { should eq description }
        end
      end
    end
  end
end
