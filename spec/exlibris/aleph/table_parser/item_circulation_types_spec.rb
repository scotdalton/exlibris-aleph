require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe ItemCirculationTypes do
        let(:irrelevant_sub_library_codes) { Config.irrelevant_sub_libraries }
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:item_circulation_types) { ItemCirculationTypes.new(admin_library) }
        describe '#filename' do
          subject { item_circulation_types.filename }
          it { should eq 'tab15.eng' }
        end
        describe '#all' do
          subject { item_circulation_types.all }
          it { should be_an Array }
          it { should_not be_empty }
          it 'should contain Collections' do
            subject.each do |collection|
              expect(collection).to be_a Item::CirculationType
            end
          end
          it 'should not include irrelevant codes' do
            subject.find do |item_circulation_type|
              expect(irrelevant_sub_library_codes).not_to include(item_circulation_type.identifier.sub_library.code)
            end
          end
        end
      end
    end
  end
end
