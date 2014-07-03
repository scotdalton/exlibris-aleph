require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe CirculationPolicy do
        let(:status) { Status.new('01', 'Patron') }
        let(:admin_library) { AdminLibrary.new('ADM50') }
        let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
        let(:identifier) { CirculationPolicy::Identifier.new(status, sub_library) }
        let(:row) { double }
        let(:borrow) { 'Y' }
        let(:photocopy) { 'Y' }
        let(:request) { 'Y' }
        let(:request_multiple) { 'Y' }
        let(:request_on_shelf) { 'Y' }
        let(:renew) { 'Y' }
        let(:book) { 'Y' }
        let(:rush_cataloging) { 'Y' }
        before do
          allow(row).to receive(:borrow).and_return(borrow)
          allow(row).to receive(:photocopy).and_return(photocopy)
          allow(row).to receive(:request).and_return(borrow)
          allow(row).to receive(:request_multiple).and_return(borrow)
          allow(row).to receive(:request_on_shelf).and_return(borrow)
          allow(row).to receive(:renew).and_return(borrow)
          allow(row).to receive(:book).and_return(borrow)
          allow(row).to receive(:rush_cataloging).and_return(borrow)
        end
        let(:privileges) { CirculationPolicy::Privileges.new(row) }
        subject(:circulation_policy) { CirculationPolicy.new(identifier, privileges) }
        it { should be_a CirculationPolicy }
        describe '#identifier' do
          subject { circulation_policy.identifier }
          it { should eq identifier }
        end
        describe '#privileges' do
          subject { circulation_policy.privileges }
          it { should eq privileges }
        end
        describe '#==' do
          subject { circulation_policy == other_object }
          context 'when the other object is an Patron::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('02', 'Patron') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Patron::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { circulation_policy === other_object }
          context 'when the other object is an Patron::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('02', 'Patron') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Patron::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { circulation_policy.eql?(other_object) }
          context 'when the other object is an Patron::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('02', 'Patron') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Patron::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        context 'when initialized with arguments' do
          context 'but the "identifier" argument is not an Patron::CirculationPolicy::Identifier' do
            let(:identifier) { "invalid" }
            it 'should raise an ArgumentError' do
              expect { subject }.to raise_error ArgumentError
            end
          end
          context 'and the "identifier" argument is an Patron::CirculationPolicy::Identifier' do
            context 'but the "privileges" argument is not a Patron::CirculationPolicy::Privileges' do
              let(:privileges) { "invalid" }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
          end
        end
      end
    end
  end
end
