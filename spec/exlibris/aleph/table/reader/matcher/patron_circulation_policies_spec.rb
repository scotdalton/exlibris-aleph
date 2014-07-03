require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          describe PatronCirculationPolicies do
            let(:string) { 'BOBST 03 Y N Y N Y Y Y N F A   20130831 0000000500 N N N 20 N N N N' }
            subject(:patron_circulation_policies) { PatronCirculationPolicies.new(string) }
            it { should be_a PatronCirculationPolicies }
            describe PatronCirculationPolicies::REGEXP do
              subject { PatronCirculationPolicies::REGEXP }
              it { should eq /^(.{5})\s([0-9#]{2})\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([CF])\s([+A])\s([DMY\s])\s([0-9]{8})\s([0-9]{10})\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YN])\s([YN])\s([YN])\s([YN])$/ }
            end
            describe '#regexp' do
              subject { patron_circulation_policies.regexp }
              it { should be_a Regexp }
              it { should eq /^(.{5})\s([0-9#]{2})\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([CF])\s([+A])\s([DMY\s])\s([0-9]{8})\s([0-9]{10})\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YN])\s([YN])\s([YN])\s([YN])$/ }
            end
            describe '#match_data' do
              subject { patron_circulation_policies.match_data }
              it { should be_a MatchData }
            end
            describe '#matches?' do
              subject { patron_circulation_policies.matches? }
              it { should be_true }
            end
            describe '#matched_data' do
              subject { patron_circulation_policies.matched_data }
              it { should be_an Array }
              it 'should have 23 matches' do
                expect(subject.size).to eq 23
              end
            end
          end
        end
      end
    end
  end
end
