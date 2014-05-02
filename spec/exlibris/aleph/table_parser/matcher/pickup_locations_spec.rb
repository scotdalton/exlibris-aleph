require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Matcher
        describe PickupLocations do
          let(:string) { 'BOBST ## ## 50 # BOBST NCOUR NIFA  NISAW NREI  NPOLY NYUAB NYUSE NYUSS' }
          subject(:pickup_locations) { PickupLocations.new(string) }
          it { should be_a PickupLocations }
          describe PickupLocations::REGEXP do
            subject { PickupLocations::REGEXP }
            it { should eq /^(.{5})\s([0-9#]{2})\s(.{2})\s(.{2})\s([YN#])\s(.{2}.?.?.?)\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?/ }
          end
          describe '#regexp' do
            subject { pickup_locations.regexp }
            it { should be_a Regexp }
            it { should eq /^(.{5})\s([0-9#]{2})\s(.{2})\s(.{2})\s([YN#])\s(.{2}.?.?.?)\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?/ }
          end
          describe '#match_data' do
            subject { pickup_locations.match_data }
            it { should be_a MatchData }
          end
          describe '#matches?' do
            subject { pickup_locations.matches? }
            it { should be_true }
          end
          describe '#matched_data' do
            subject { pickup_locations.matched_data }
            it { should be_an Array }
            it 'should have 15 matches' do
              expect(subject.size).to eq 15
            end
          end
        end
      end
    end
  end
end
