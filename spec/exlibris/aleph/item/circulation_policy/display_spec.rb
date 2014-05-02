require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      class CirculationPolicy
        describe Display do
          let(:value) { 'Display' }
          let(:mask) { 'Display Mask' }
          subject(:display) { Display.new(value, mask) }
          it { should be_a Display }
          describe '#value' do
            subject { display.value }
            it { should eq value }
          end
          describe '#mask' do
            subject { display.mask }
            it { should eq mask }
            context 'when the mask is not given' do
              let(:display) { Display.new(value) }
              it { should eq value }
            end
            context 'when the mask is given' do
              context 'and the mask is nil' do
                let(:mask) { nil }
                it { should eq value }
              end
            end
          end
        end
      end
    end
  end
end
