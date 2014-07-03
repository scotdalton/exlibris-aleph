require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        describe Base do
          let(:admin_library) { AdminLibrary.new('ADM50') }
          let(:filename) { 'filename' }
          subject(:base) { Base.new(admin_library, filename) }
          describe '#admin_library' do
            subject { base.admin_library }
            it { should eq admin_library }
          end
          describe '#filename' do
            subject { base.filename }
            it { should eq filename }
          end
          describe '#all' do
            subject { base.all }
            it 'should raise a RuntimeError' do
              expect { subject }.to raise_error RuntimeError
            end
          end
        end
      end
    end
  end
end
