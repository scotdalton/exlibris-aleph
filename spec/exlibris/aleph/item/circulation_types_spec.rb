require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      describe CirculationTypes do
        subject(:item_circulation_types) { CirculationTypes.instance }
        describe '#all' do
          subject { item_circulation_types.all }
          it { should be_an Hash }
          it { should_not be_empty }
        end
        describe '#each' do
          subject { item_circulation_types.each }
          it { should be_an Enumerable }
        end
        describe '#equal?' do
          let(:other_instance) { CirculationTypes.instance }
          subject { item_circulation_types.equal?(other_instance) }
          it { should be_true }
        end
      end
    end
  end
end
