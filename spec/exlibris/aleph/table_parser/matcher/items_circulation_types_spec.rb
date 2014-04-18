# /^(.{5})\s([0-9#]{2})\s([A-Z#]{2})\s(L)\s(.{30})\s([YN])\s([YN])\s([YNCT])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YNC])\s([AOC])/
require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Matcher
        describe ItemCirculationTypes do
          let(:string) { 'BOBST ## DP L Depository                     Y Y C N Y Y N Y N 00 N A' }
          subject(:items) { ItemCirculationTypes.new(string) }
          describe ItemCirculationTypes::REGEXP do
            subject { ItemCirculationTypes::REGEXP }
            it { should eq /^(.{5})\s([0-9#]{2})\s([A-Z#]{2})\s(L)\s(.{30})\s([YN])\s([YN])\s([YNCT])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YNC])\s([AOC])/ }
          end
          describe '#regexp' do
            subject { items.regexp }
            it { should be_a Regexp }
            it { should eq /^(.{5})\s([0-9#]{2})\s([A-Z#]{2})\s(L)\s(.{30})\s([YN])\s([YN])\s([YNCT])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YNC])\s([AOC])/ }
          end
          describe '#match_data' do
            subject { items.match_data }
            it { should be_a MatchData }
          end
          describe '#matches?' do
            subject { items.matches? }
            it { should be_true }
          end
          describe '#matched_data' do
            subject { items.matched_data }
            it { should be_an Array }
            it 'should have 17 matches' do
              expect(subject.size).to eq 17
            end
          end
        end
      end
    end
  end
end
