module Exlibris
  module Aleph
    module TableParser
      module Row
        describe PatronPrivileges do
          let(:data) { [] }
          subject(:patron_privileges) { PatronPrivileges.new(data) }
          it { should be_a Base }
          it { should be_a PatronPrivileges }
          describe '#data' do
            subject { patron_privileges.data }
            it { should eq data }
          end
        end
      end
    end
  end
end
