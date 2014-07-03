require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Item
        describe CirculationPolicies do
          subject(:item_circulation_policies) { CirculationPolicies.new }
          describe '#all' do
            subject { item_circulation_policies.all }
            it { should be_an Hash }
            it { should_not be_empty }
          end
          describe '#each' do
            subject { item_circulation_policies.each }
            it { should be_an Enumerable }
          end
          describe '#find_by_identifier' do
            subject { item_circulation_policies.find_by_identifier(identifier) }
            context 'when the identifier is not an Item::CirculationPolicies::Identifier' do
              let(:identifier) { 'identifier' }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'when the identifier is an Item::CirculationPolicies::Identifier' do
              let(:item_status) { Aleph::Item::Status.new('01') }
              let(:item_processing_status) { Aleph::Item::ProcessingStatus.new('BD') }
              let(:admin_library) { AdminLibrary.new('NYU50') }
              let(:sub_library) { SubLibrary.new('BOBST', 'NYU Bobst', admin_library) }
              let(:identifier) { Aleph::Item::CirculationPolicy::Identifier.new(item_status, item_processing_status, sub_library) }
              context "and the identifier exactly matches a CirculationPolicy's Identifier" do
                it { should_not be_nil }
                it { should be_a Aleph::Item::CirculationPolicy }
              end
              context "but the identifier does not exactly match any CirculationPolicy's Identifier" do
                context 'because the item status does not match' do
                  let(:item_processing_status) { Aleph::Item::Status.new('ACK') }
                  context 'and the item process status does not match' do
                    let(:item_processing_status) { Aleph::Item::ProcessingStatus.new('ACK') }
                    it { should_not be_nil }
                    it { should be_a Aleph::Item::CirculationPolicy }
                  end
                  context 'but the item process status does match' do
                    context 'and there is a generic row that matches' do
                      let(:item_processing_status) { Aleph::Item::ProcessingStatus.new('DP') }
                      it { should_not be_nil }
                      it { should be_a Aleph::Item::CirculationPolicy }
                    end
                  end
                end
                context 'because the item status does match' do
                  context 'but the item process status does not match' do
                    let(:item_processing_status) { Aleph::Item::ProcessingStatus.new('ACK') }
                    it { should_not be_nil }
                    it { should be_a Aleph::Item::CirculationPolicy }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
