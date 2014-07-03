require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Item
        describe DisplayMasks do
          subject(:display_masks) { DisplayMasks.new }
          describe '#all' do
            subject { display_masks.all }
            it { should be_an Hash }
            it { should_not be_empty }
          end
          describe '#each' do
            subject { display_masks.each }
            it { should be_an Enumerable }
          end
          describe '#[]' do
            let(:admin_library) { AdminLibrary.new('NYU50') }
            subject { display_masks[admin_library] }
            it { should be_an Array }
          end
        end
      end
    end
  end
end
