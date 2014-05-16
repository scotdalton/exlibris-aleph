require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          describe CirculationPolicy do
            let(:hold_request) { 'N' }
            let(:short_loan) { 'N' }
            let(:photocopy_request) { 'N' }
            let(:booking_request) { 'N' }
            let(:arg) { double }
            before do
              allow(arg).to receive(:hold_request).and_return(hold_request)
              allow(arg).to receive(:short_loan).and_return(short_loan)
              allow(arg).to receive(:photocopy_request).and_return(photocopy_request)
              allow(arg).to receive(:booking_request).and_return(booking_request)
            end
            let(:privileges) { CirculationPolicy::Privileges.new(arg) }
            let(:pickup_locations) do
              [
                PickupLocation.new('PICK1', 'Pickup Location 1'),
                PickupLocation.new('PICK2', 'Pickup Location 2')
              ]
            end
            subject(:circulation_policy) { CirculationPolicy.new(privileges, *pickup_locations) }
            describe '#privileges' do
              subject { circulation_policy.privileges }
              it { should eq privileges }
            end
            describe '#pickup_locations' do
              subject { circulation_policy.pickup_locations }
              it { should be_an Array }
              it { should_not be_empty }
              it { should eq pickup_locations }
              context 'when initialized with no pickup locations' do
                let(:circulation_policy) { CirculationPolicy.new(privileges) }
                it { should be_empty }
              end
            end
            context 'when the privileges argument is not a CirculationPolicy::Privileges' do
              let(:privileges) { 'invalid' }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
          end
        end
      end
    end
  end
end
