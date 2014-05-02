require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Row
        describe SubLibraries do
          let(:data) { ['BOBST', '1', 'NYU50', 'L', 'NYU Bobst                     '] }
          subject(:sub_libraries) { SubLibraries.new(data) }
          it { should be_a Base }
          it { should be_a SubLibraries }
          describe '#data' do
            subject { sub_libraries.data }
            it { should eq data }
          end
          describe '#code' do
            subject { sub_libraries.code }
            it { should eq 'BOBST' }
          end
          describe '#type' do
            subject { sub_libraries.type }
            it { should eq '1' }
          end
          describe '#admin_library_code' do
            subject { sub_libraries.admin_library_code }
            it { should eq 'NYU50' }
          end
          describe '#alpha' do
            subject { sub_libraries.alpha }
            it { should eq 'L' }
          end
          describe '#display' do
            subject { sub_libraries.display }
            it { should eq 'NYU Bobst' }
          end
        end
      end
    end
  end
end
