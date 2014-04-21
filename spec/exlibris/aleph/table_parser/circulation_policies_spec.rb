require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe ItemCirculationPolicies do
        let(:irrelevant_sub_library_codes) { Config.irrelevant_sub_libraries }
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:item_circulation_policies) { ItemCirculationPolicies.new(admin_library) }
        describe '#filename' do
          subject { item_circulation_policies.filename }
          it { should eq 'tab15.eng' }
        end
        describe '#all' do
          subject { item_circulation_policies.all }
          it { should be_an Array }
          it { should_not be_empty }
          it 'should contain Collections' do
            subject.each do |collection|
              expect(collection).to be_a Item::CirculationPolicy
            end
          end
          it 'should not include irrelevant codes' do
            subject.find do |item_circulation_policy|
              expect(irrelevant_sub_library_codes).not_to include(item_circulation_policy.identifier.sub_library.code)
            end
          end
        end
      end
    end
  end
end
