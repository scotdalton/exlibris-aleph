require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe PatronPrivileges do
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:patron_privileges) { PatronPrivileges.new(admin_library) }
        describe '#filename' do
          subject { patron_privileges.filename }
          it { should eq 'tab31' }
        end
      end
    end
  end
end
