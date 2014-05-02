require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      describe PatronCirculationPolicies do
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject(:patron_circulation_policies) { PatronCirculationPolicies.new(admin_library) }
        describe '#filename' do
          subject { patron_circulation_policies.filename }
          it { should eq 'tab31' }
        end
        describe '#all' do
          subject { patron_circulation_policies.all }
          it { should be_an Array }
          it { should_not be_empty }
          it 'should contain Patron::CirculationPolicy elements' do
            subject.each do |patron_circulation_policy|
              expect(patron_circulation_policy).to be_a Patron::CirculationPolicy
            end
          end
        end
      end
    end
  end
end
