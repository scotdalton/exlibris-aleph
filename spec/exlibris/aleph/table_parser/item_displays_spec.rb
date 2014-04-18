require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe ItemDisplays do
        let(:admin_library) { AdminLibrary.new('ADM50') }
        subject(:item_displays) { ItemDisplays.new(admin_library) }
        describe '#filename' do
          subject { item_displays.filename }
          it { should eq 'tab_www_item_desc.eng' }
        end
      end
    end
  end
end
