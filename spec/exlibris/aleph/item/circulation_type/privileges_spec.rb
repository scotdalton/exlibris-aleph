require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      class CirculationType
        describe Privileges do
          let(:row) { double }
          let(:loanable) { 'Y' }
          let(:renewable) { 'Y' }
          let(:requestable) { 'Y' }
          let(:photocopyable) { 'Y' }
          let(:displayable) { 'Y' }
          let(:specific_item) { 'Y' }
          let(:limit_hold) { 'Y' }
          let(:recallable) { 'Y' }
          let(:rush_recallable) { 'Y' }
          let(:reloaning_limit) { '00' }
          let(:bookable) { 'Y' }
          let(:booking_hours) { 'A' }
          before do
            allow(row).to receive(:loanable).and_return(loanable)
            allow(row).to receive(:renewable).and_return(renewable)
            allow(row).to receive(:requestable).and_return(requestable)
            allow(row).to receive(:photocopyable).and_return(photocopyable)
            allow(row).to receive(:displayable).and_return(displayable)
            allow(row).to receive(:specific_item).and_return(specific_item)
            allow(row).to receive(:limit_hold).and_return(limit_hold)
            allow(row).to receive(:recallable).and_return(recallable)
            allow(row).to receive(:rush_recallable).and_return(photocopyable)
            allow(row).to receive(:reloaning_limit).and_return(rush_recallable)
            allow(row).to receive(:bookable).and_return(bookable)
            allow(row).to receive(:booking_hours).and_return(booking_hours)
          end
          subject(:privileges) { Privileges.new(row) }
          describe '#loanable' do
            subject { privileges.loanable }
            it { should eq loanable }
          end
          describe '#loanable?' do
            subject { privileges.loanable? }
            it { should be_true }
          end
          describe '#renewable' do
            subject { privileges.renewable }
            it { should eq renewable }
          end
          describe '#renewable?' do
            subject { privileges.renewable? }
            it { should be_true }
          end
          describe '#requestable' do
            subject { privileges.requestable }
            it { should eq requestable }
          end
          describe '#requestable?' do
            subject { privileges.requestable? }
            it { should be_true }
          end
          describe '#photocopyable' do
            subject { privileges.photocopyable }
            it { should eq photocopyable }
          end
          describe '#photocopyable?' do
            subject { privileges.photocopyable? }
            it { should be_true }
          end
        end
      end
    end
  end
end
