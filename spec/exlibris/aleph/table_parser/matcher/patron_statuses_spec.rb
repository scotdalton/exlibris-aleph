require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Matcher
        describe PatronStatuses do
          let(:string) { 'BOR-STATUS           ##### L Palmer Faculty                                     03' }
          subject(:patron_statuses) { PatronStatuses.new(string) }
          it { should be_a PatronStatuses }
          describe PatronStatuses::REGEXP do
            subject { PatronStatuses::REGEXP }
            it { should eq /^BOR-STATUS\s{10}\s.{5}\sL\s(.{50})\s(.*)$/ }
          end
          describe '#regexp' do
            subject { patron_statuses.regexp }
            it { should be_a Regexp }
            it { should eq /^BOR-STATUS\s{10}\s.{5}\sL\s(.{50})\s(.*)$/ }
          end
          describe '#match_data' do
            subject { patron_statuses.match_data }
            it { should be_a MatchData }
          end
          describe '#matches?' do
            subject { patron_statuses.matches? }
            it { should be_true }
          end
          describe '#matched_data' do
            subject { patron_statuses.matched_data }
            it { should be_an Array }
            it 'should have 2 matches' do
              expect(subject.size).to eq 2
            end
          end
        end
      end
    end
  end
end
