require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        describe CirculationPolicy do
          let(:hold_request) { 'N' }
          let(:short_loan) { 'N' }
          let(:ill) { 'N' }
          let(:booking_request) { 'N' }
          let(:acquisition_request) { 'N' }
          let(:arg) { double }
          before do
            allow(arg).to receive(:hold_request).and_return(hold_request)
            allow(arg).to receive(:short_loan).and_return(short_loan)
            allow(arg).to receive(:ill).and_return(ill)
            allow(arg).to receive(:booking_request).and_return(booking_request)
            allow(arg).to receive(:acquisition_request).and_return(acquisition_request)
          end
          let(:privileges) { CirculationPolicy::Privileges.new(arg) }
          subject(:circulation_policy) { CirculationPolicy.new(privileges) }
          it { should be_a CirculationPolicy }
          describe '#privileges' do
            subject { circulation_policy.privileges }
            it { should eq privileges }
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
