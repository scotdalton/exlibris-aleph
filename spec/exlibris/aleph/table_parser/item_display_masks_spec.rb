require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe ItemDisplayMasks do
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:item_display_masks) { ItemDisplayMasks.new(admin_library) }
        describe '#filename' do
          subject { item_display_masks.filename }
          it { should eq 'tab_www_item_desc.eng' }
        end
        describe '#all' do
          subject { item_display_masks.all }
          it { should be_an Array }
          it { should_not be_empty }
          it 'should contain ItemDisplayMask' do
            subject.each do |item_display_mask|
              expect(item_display_mask).to be_a Item::DisplayMask
            end
          end
        end
      end
    end
  end
end
