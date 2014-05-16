require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          describe ItemDisplayMasks do
            let(:string) { 'ITEM-STATUS     Lost/Claimed                                                                     Request ILL' }
            subject(:item_display_masks) { ItemDisplayMasks.new(string) }
            it { should be_a ItemDisplayMasks }
            describe ItemDisplayMasks::REGEXP do
              subject { ItemDisplayMasks::REGEXP }
              it { should eq /^ITEM-STATUS    \s(.{80})\s(.*)$/ }
            end
            describe '#regexp' do
              subject { item_display_masks.regexp }
              it { should be_a Regexp }
              it { should eq /^ITEM-STATUS    \s(.{80})\s(.*)$/ }
            end
            describe '#match_data' do
              subject { item_display_masks.match_data }
              it { should be_a MatchData }
            end
            describe '#matches?' do
              subject { item_display_masks.matches? }
              it { should be_true }
            end
            describe '#matched_data' do
              subject { item_display_masks.matched_data }
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
end
