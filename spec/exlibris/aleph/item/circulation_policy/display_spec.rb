require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      class CirculationPolicy
        describe Display do
          let(:value) { 'Display' }
          subject(:display) { Display.new(value) }
          it { should be_a Display }
          describe '#value' do
            subject { display.value }
            it { should eq value }
          end
          describe '#mask' do
            subject { display.mask }
          end
        end
      end
    end
  end
end
