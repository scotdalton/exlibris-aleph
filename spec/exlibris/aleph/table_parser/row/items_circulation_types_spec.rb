module Exlibris
  module Aleph
    module TableParser
      module Row
        describe ItemCirculationTypes do
          let(:data) { ["BOBST", "##", "DP", "L", "Depository                    ", "Y", "Y", "C", "N", "Y", "Y", "N", "Y", "N", "00", "N", "A"] }
          subject(:item_circulation_types) { ItemCirculationTypes.new(data) }
          it { should be_a Base }
          it { should be_a ItemCirculationTypes }
          describe '#data' do
            subject { item_circulation_types.data }
            it { should eq data }
          end
          describe '#sub_library_code' do
            subject { item_circulation_types.sub_library_code }
            it { should eq 'BOBST' }
          end
          describe '#status_code' do
            subject { item_circulation_types.status_code }
            it { should eq '##' }
          end
          describe '#processing_status_code' do
            subject { item_circulation_types.processing_status_code }
            it { should eq 'DP' }
          end
          describe '#alpha' do
            subject { item_circulation_types.alpha }
            it { should eq 'L' }
          end
          describe '#display' do
            subject { item_circulation_types.display }
            it { should eq 'Depository' }
          end
          describe '#loanable' do
            subject { item_circulation_types.loanable }
            it { should eq 'Y' }
          end
          describe '#renewable' do
            subject { item_circulation_types.renewable }
            it { should eq 'Y' }
          end
          describe '#requestable' do
            subject { item_circulation_types.requestable }
            it { should eq 'C' }
          end
          describe '#photocopyable' do
            subject { item_circulation_types.photocopyable }
            it { should eq 'N' }
          end
          describe '#displayable' do
            subject { item_circulation_types.displayable }
            it { should eq 'Y' }
          end
          describe '#specific_item' do
            subject { item_circulation_types.specific_item }
            it { should eq 'Y' }
          end
          describe '#limit_hold' do
            subject { item_circulation_types.limit_hold }
            it { should eq 'N' }
          end
          describe '#recallable' do
            subject { item_circulation_types.recallable }
            it { should eq 'Y' }
          end
          describe '#rush_recallable' do
            subject { item_circulation_types.rush_recallable }
            it { should eq 'N' }
          end
          describe '#reloaning_limit' do
            subject { item_circulation_types.reloaning_limit }
            it { should eq '00' }
          end
          describe '#bookable' do
            subject { item_circulation_types.bookable }
            it { should eq 'N' }
          end
          describe '#booking_hours' do
            subject { item_circulation_types.booking_hours }
            it { should eq 'A' }
          end
        end
      end
    end
  end
end
