require 'spec_helper'
module Exlibris
  module Aleph
    describe PickupLocation do
      let(:code) { 'PICK' }
      let(:display) { 'Pickup Location' }
      subject(:pickup_location) { PickupLocation.new(code, display) }
      it { should be_a PickupLocation }
      describe '#code' do
        subject { pickup_location.code }
        it { should eq code }
      end
      describe '#display' do
        subject { pickup_location.display }
        it { should eq display }
      end
    end
  end
end
