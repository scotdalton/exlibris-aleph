require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      class CirculationPolicy
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
            allow(row).to receive(:rush_recallable).and_return(rush_recallable)
            allow(row).to receive(:reloaning_limit).and_return(reloaning_limit)
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
            context 'when the item is not loanable' do
              let(:loanable) { 'N' }
              it { should be_false }
            end
          end
          describe '#renewable' do
            subject { privileges.renewable }
            it { should eq renewable }
          end
          describe '#renewable?' do
            subject { privileges.renewable? }
            it { should be_true }
            context 'when the item is not renewable' do
              let(:renewable) { 'N' }
              it { should be_false }
            end
          end
          describe '#requestable' do
            subject { privileges.requestable }
            it { should eq requestable }
          end
          describe '#requestable?' do
            subject { privileges.requestable? }
            it { should be_true }
            context 'when the item is not requestable' do
              let(:requestable) { 'N' }
              it { should be_false }
            end
            context 'when the item is always requestable' do
              let(:requestable) { 'C' }
              it { should be_true }
            end
          end
          describe '#always_requestable?' do
            subject { privileges.always_requestable? }
            it { should be_false }
            context 'when the item is not requestable' do
              let(:requestable) { 'N' }
              it { should be_false }
            end
            context 'when the item is always requestable' do
              let(:requestable) { 'C' }
              it { should be_true }
            end
          end
          describe '#photocopyable' do
            subject { privileges.photocopyable }
            it { should eq photocopyable }
          end
          describe '#photocopyable?' do
            subject { privileges.photocopyable? }
            it { should be_true }
            context 'when the item is not photocopyable' do
              let(:photocopyable) { 'N' }
              it { should be_false }
            end
          end
          describe '#displayable' do
            subject { privileges.displayable }
            it { should eq displayable }
          end
          describe '#displayable?' do
            subject { privileges.displayable? }
            it { should be_true }
            context 'when the item is not displayable' do
              let(:displayable) { 'N' }
              it { should be_false }
            end
          end
          describe '#specific_item' do
            subject { privileges.specific_item }
            it { should eq specific_item }
          end
          describe '#specific_item?' do
            subject { privileges.specific_item? }
            it { should be_true }
            context 'when item requests are not for specific items' do
              let(:specific_item) { 'N' }
              it { should be_false }
            end
          end
          describe '#limit_hold' do
            subject { privileges.limit_hold }
            it { should eq limit_hold }
          end
          describe '#limit_hold?' do
            subject { privileges.limit_hold? }
            it { should be_true }
            context 'when the item is has no hold limit' do
              let(:limit_hold) { 'N' }
              it { should be_false }
            end
          end
          describe '#recallable' do
            subject { privileges.recallable }
            it { should eq recallable }
          end
          describe '#recallable?' do
            subject { privileges.recallable? }
            it { should be_true }
            context 'when the item is not recallable' do
              let(:recallable) { 'N' }
              it { should be_false }
            end
          end
          describe '#rush_recallable' do
            subject { privileges.rush_recallable }
            it { should eq rush_recallable }
          end
          describe '#rush_recallable?' do
            subject { privileges.rush_recallable? }
            it { should be_true }
            context 'when the item is not "rush" recallable' do
              let(:rush_recallable) { 'N' }
              it { should be_false }
            end
          end
          describe '#reloaning_limit' do
            subject { privileges.reloaning_limit }
            it { should eq reloaning_limit }
          end
          describe '#bookable' do
            subject { privileges.bookable }
            it { should eq bookable }
          end
          describe '#bookable?' do
            subject { privileges.bookable? }
            it { should be_true }
            context 'when the item is not bookable' do
              let(:bookable) { 'N' }
              it { should be_false }
            end
          end
          describe '#booking_hours' do
            subject { privileges.booking_hours }
            it { should eq booking_hours }
          end
        end
      end
    end
  end
end
