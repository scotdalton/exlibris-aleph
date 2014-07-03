require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class Record
        class CirculationPolicy
          describe Privileges do
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
            subject(:privileges) { Privileges.new(arg) }
            it { should be_a Privileges }
            describe '#hold_request' do
              subject { privileges.hold_request }
              it { should eq 'N' }
            end
            describe '#hold_request?' do
              subject { privileges.hold_request? }
              it { should be_false }
              context 'when the hold request value is "Y"' do
                let(:hold_request) { 'Y' }
                it { should be_true }
              end
            end
            describe '#short_loan' do
              subject { privileges.short_loan }
              it { should eq 'N' }
            end
            describe '#short_loan?' do
              subject { privileges.short_loan? }
              it { should be_false }
              context 'when the short loan value is "Y"' do
                let(:short_loan) { 'Y' }
                it { should be_true }
              end
            end
            describe '#ill' do
              subject { privileges.ill }
              it { should eq 'N' }
            end
            describe '#ill?' do
              subject { privileges.ill? }
              it { should be_false }
              context 'when the ill value is "Y"' do
                let(:ill) { 'Y' }
                it { should be_true }
              end
            end
            describe '#booking_request' do
              subject { privileges.booking_request }
              it { should eq 'N' }
            end
            describe '#booking_request?' do
              subject { privileges.booking_request? }
              it { should be_false }
              context 'when the booking request value is "Y"' do
                let(:booking_request) { 'Y' }
                it { should be_true }
              end
            end
            describe '#acquisition_request' do
              subject { privileges.acquisition_request }
              it { should eq 'N' }
            end
            describe '#acquisition_request?' do
              subject { privileges.acquisition_request? }
              it { should be_false }
              context 'when the acquisition request value is "Y"' do
                let(:acquisition_request) { 'Y' }
                it { should be_true }
              end
            end
          end
        end
      end
    end
  end
end
