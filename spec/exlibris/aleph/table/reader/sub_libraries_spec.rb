require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        describe SubLibraries do
          let(:irrelevant_codes) { Config.irrelevant_sub_libraries }
          subject(:sub_libraries) { SubLibraries.new }
          describe '#admin_library' do
            subject { sub_libraries.admin_library }
            it { should eq AdminLibrary.new('alephe') }
          end
          describe '#filename' do
            subject { sub_libraries.filename }
            it { should eq 'tab_sub_library.eng' }
          end
          describe '#all' do
            subject { sub_libraries.all }
            it { should be_an Array }
            it { should_not be_empty }
            it 'should contain SubLibraries' do
              subject.each do |sub_library|
                expect(sub_library).to be_a SubLibrary
              end
            end
            it 'should not include irrelevant codes' do
              subject.find do |sub_library|
                expect(irrelevant_codes).not_to include(sub_library.code)
              end
            end
          end
        end
      end
    end
  end
end
