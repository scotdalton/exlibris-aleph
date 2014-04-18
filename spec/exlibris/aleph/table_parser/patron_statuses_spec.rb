require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe PatronStatuses do
        let(:admin_library) { AdminLibrary.new('ADM50') }
        subject(:patron_statuses) { PatronStatuses.new(admin_library) }
        describe '#filename' do
          subject { patron_statuses.filename }
          it { should eq 'pc_tab_exp_field_extended.eng' }
        end
      end
    end
  end
end
