require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe PickupLocations do
        let(:admin_library) { AdminLibrary.new('ADM50') }
        subject(:pickup_locations) { PickupLocations.new(admin_library) }
        describe '#filename' do
          subject { pickup_locations.filename }
          it { should eq 'tab37' }
        end
      end
    end
  end
end
