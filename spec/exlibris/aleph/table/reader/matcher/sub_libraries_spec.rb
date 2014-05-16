require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          describe SubLibraries do
            let(:string) { 'BOBST 1 NYU50 L NYU Bobst                      BOBST BOBST BOBST BOBST NYU50 ALEPH' }
            subject(:sub_libraries) { SubLibraries.new(string) }
            it { should be_a SubLibraries }
            describe SubLibraries::REGEXP do
              subject { SubLibraries::REGEXP }
              it { should eq /^(.{5})\s([1-6]{1})\s(.{5})\s([L,H,A,R,S]{1})\s(.{1,30})/ }
            end
            describe '#regexp' do
              subject { sub_libraries.regexp }
              it { should be_a Regexp }
              it { should eq /^(.{5})\s([1-6]{1})\s(.{5})\s([L,H,A,R,S]{1})\s(.{1,30})/ }
            end
            describe '#match_data' do
              subject { sub_libraries.match_data }
              it { should be_a MatchData }
            end
            describe '#matches?' do
              subject { sub_libraries.matches? }
              it { should be_true }
            end
            describe '#matched_data' do
              subject { sub_libraries.matched_data }
              it { should be_an Array }
              it 'should have 5 matches' do
                expect(subject.size).to eq 5
              end
            end
          end
        end
      end
    end
  end
end
