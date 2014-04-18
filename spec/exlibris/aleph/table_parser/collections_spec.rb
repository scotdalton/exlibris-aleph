require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe Collections do
        let(:irrelevant_sub_library_codes) { Config.irrelevant_sub_libraries }
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:collections) { Collections.new(admin_library) }
        describe '#filename' do
          subject { collections.filename }
          it { should eq 'tab40.eng' }
        end
        describe '#all' do
          subject { collections.all }
          it { should be_an Array }
          it { should_not be_empty }
          it 'should contain Collections' do
            subject.each do |collection|
              expect(collection).to be_a Collection
            end
          end
          it 'should not include irrelevant codes' do
            subject.find do |collection|
              expect(irrelevant_sub_library_codes).not_to include(collection.sub_library.code)
            end
          end
        end
      end
    end
  end
end
