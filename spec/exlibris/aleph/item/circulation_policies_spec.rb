require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      describe CirculationPolicies do
        subject(:item_circulation_policies) { CirculationPolicies.instance }
        describe '#all' do
          subject { item_circulation_policies.all }
          it { should be_an Hash }
          it { should_not be_empty }
        end
        describe '#each' do
          subject { item_circulation_policies.each }
          it { should be_an Enumerable }
        end
        describe '#equal?' do
          let(:other_instance) { CirculationPolicies.instance }
          subject { item_circulation_policies.equal?(other_instance) }
          it { should be_true }
        end
      end
    end
  end
end
