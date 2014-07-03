require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          describe ItemDisplayMasks do
            let(:data) { ['Lost/Claimed                                                                     ', 'Request ILL'] }
            subject(:item_display_masks) { ItemDisplayMasks.new(data) }
            it { should be_a Base }
            it { should be_a ItemDisplayMasks }
            describe '#data' do
              subject { item_display_masks.data }
              it { should eq data }
            end
            describe '#display' do
              subject { item_display_masks.display }
              it { should eq 'Lost/Claimed' }
            end
            describe '#mask' do
              subject { item_display_masks.mask }
              it { should eq 'Request ILL' }
            end
          end
        end
      end
    end
  end
end
