require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Row
        describe PickupLocations do
          let(:data) { ['BOBST', '##', '##', '50', '#', 'BOBST', 'NCOUR',
            'NIFA ', 'NISAW', 'NREI ', 'NPOLY', 'NYUAB', 'NYUSE', 'NYUSS'] }
          subject(:pickup_locations) { PickupLocations.new(data) }
          it { should be_a Base }
          it { should be_a PickupLocations }
          describe '#data' do
            subject { pickup_locations.data }
            it { should eq data }
          end
          describe '#sub_library_code' do
            subject { pickup_locations.sub_library_code }
            it { should eq 'BOBST' }
          end
          describe '#item_status_code' do
            subject { pickup_locations.item_status_code }
            it { should eq '##' }
          end
          describe '#item_processing_status_code' do
            subject { pickup_locations.item_processing_status_code }
            it { should eq '##' }
          end
          describe '#patron_status_code' do
            subject { pickup_locations.patron_status_code }
            it { should eq '50' }
          end
          describe '#availability_flag' do
            subject { pickup_locations.availability_flag }
            it { should eq '#' }
          end
          describe '#pickup_locations' do
            let(:expected_pickup_locations) do
              %w{ BOBST NCOUR NIFA NISAW NREI NPOLY NYUAB NYUSE NYUSS }
            end
            subject { pickup_locations.pickup_locations }
            it { should be_an Array }
            it { should eq expected_pickup_locations }
          end
        end
      end
    end
  end
end
