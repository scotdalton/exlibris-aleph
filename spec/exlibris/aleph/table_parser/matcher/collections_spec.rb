require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Matcher
        describe Collections do
          let(:string) { 'MAIN  BOBST L Main Collection' }
          subject(:collections) { Collections.new(string) }
          describe Collections::REGEXP do
            subject { Collections::REGEXP }
            it { should eq /^(.{5})\s(.{5})\s(L)\s(.+)/ }
          end
          describe '#regexp' do
            subject { collections.regexp }
            it { should be_a Regexp }
            it { should eq /^(.{5})\s(.{5})\s(L)\s(.+)/ }
          end
          describe '#match_data' do
            subject { collections.match_data }
            it { should be_a MatchData }
          end
          describe '#matches?' do
            subject { collections.matches? }
            it { should be_true }
          end
          describe '#matched_data' do
            subject { collections.matched_data }
            it { should be_an Array }
            it 'should have 4 matches' do
              expect(subject.size).to eq 4
            end
          end
        end
      end
    end
  end
end
