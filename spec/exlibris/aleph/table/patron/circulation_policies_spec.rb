require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Patron
        describe CirculationPolicies do
          subject(:circulation_policies) { CirculationPolicies.new }
          describe '#all' do
            subject { circulation_policies.all }
            it { should be_an Hash }
            it { should_not be_empty }
          end
          describe '#each' do
            subject { circulation_policies.each }
            it { should be_an Enumerable }
          end
          describe '#find_by_identifier' do
            subject { circulation_policies.find_by_identifier(identifier) }
            context 'when the identifier is not an Item::CirculationPolicies::Identifier' do
              let(:identifier) { 'identifier' }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'when the identifier is an Item::CirculationPolicies::Identifier' do
              let(:patron_status) { Aleph::Patron::Status.new('50', 'NYU Full Time Faculty') }
              let(:admin_library) { AdminLibrary.new('NYU50') }
              let(:sub_library) { SubLibrary.new('BOBST', 'NYU Bobst', admin_library) }
              let(:identifier) { Aleph::Patron::CirculationPolicy::Identifier.new(patron_status, sub_library) }
              context "and the identifier exactly matches a CirculationPolicy's Identifier" do
                it { should_not be_nil }
                it { should be_a Aleph::Patron::CirculationPolicy }
              end
              context "but the identifier does not exactly match any CirculationPolicy's Identifier" do
                context 'because the patron status does not match' do
                  let(:patron_status) { Aleph::Patron::Status.new('ACK', 'Ack Attack') }
                  it { should_not be_nil }
                  it { should be_a Aleph::Patron::CirculationPolicy }
                end
              end
            end
          end
        end
      end
    end
  end
end
