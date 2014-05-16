require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          describe ItemCirculationPolicies do
            let(:data) { ["BOBST", "##", "DP", "L", "Depository                    ", "Y", "Y", "C", "N", "Y", "Y", "N", "Y", "N", "00", "N", "A"] }
            subject(:item_circulation_policies) { ItemCirculationPolicies.new(data) }
            it { should be_a Base }
            it { should be_a ItemCirculationPolicies }
            describe '#data' do
              subject { item_circulation_policies.data }
              it { should eq data }
            end
            describe '#sub_library_code' do
              subject { item_circulation_policies.sub_library_code }
              it { should eq 'BOBST' }
            end
            describe '#item_status_code' do
              subject { item_circulation_policies.item_status_code }
              it { should eq '##' }
            end
            describe '#item_processing_status_code' do
              subject { item_circulation_policies.item_processing_status_code }
              it { should eq 'DP' }
            end
            describe '#alpha' do
              subject { item_circulation_policies.alpha }
              it { should eq 'L' }
            end
            describe '#display' do
              subject { item_circulation_policies.display }
              it { should eq 'Depository' }
            end
            describe '#loanable' do
              subject { item_circulation_policies.loanable }
              it { should eq 'Y' }
            end
            describe '#renewable' do
              subject { item_circulation_policies.renewable }
              it { should eq 'Y' }
            end
            describe '#requestable' do
              subject { item_circulation_policies.requestable }
              it { should eq 'C' }
            end
            describe '#photocopyable' do
              subject { item_circulation_policies.photocopyable }
              it { should eq 'N' }
            end
            describe '#displayable' do
              subject { item_circulation_policies.displayable }
              it { should eq 'Y' }
            end
            describe '#specific_item' do
              subject { item_circulation_policies.specific_item }
              it { should eq 'Y' }
            end
            describe '#limit_hold' do
              subject { item_circulation_policies.limit_hold }
              it { should eq 'N' }
            end
            describe '#recallable' do
              subject { item_circulation_policies.recallable }
              it { should eq 'Y' }
            end
            describe '#rush_recallable' do
              subject { item_circulation_policies.rush_recallable }
              it { should eq 'N' }
            end
            describe '#reloaning_limit' do
              subject { item_circulation_policies.reloaning_limit }
              it { should eq '00' }
            end
            describe '#bookable' do
              subject { item_circulation_policies.bookable }
              it { should eq 'N' }
            end
            describe '#booking_hours' do
              subject { item_circulation_policies.booking_hours }
              it { should eq 'A' }
            end
          end
        end
      end
    end
  end
end
