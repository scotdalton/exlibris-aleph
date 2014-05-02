require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe CirculationPolicy do
        let(:status_code) { '##' }
        let(:status) { Status.new(status_code) }
        let(:processing_status_code) { 'DP' }
        let(:processing_status) { ProcessingStatus.new(processing_status_code) }
        let(:admin_library) { AdminLibrary.new('ADM50') }
        let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
        let(:identifier) { CirculationPolicy::Identifier.new(status, processing_status, sub_library) }
        let(:display) { CirculationPolicy::Display.new('Display') }
        let(:row) { double }
        let(:loanable) { 'Y' }
        let(:renewable) { 'Y' }
        let(:requestable) { 'Y' }
        let(:photocopyable) { 'Y' }
        let(:displayable) { 'Y' }
        let(:specific_item) { 'Y' }
        let(:limit_hold) { 'Y' }
        let(:recallable) { 'Y' }
        let(:rush_recallable) { 'Y' }
        let(:reloaning_limit) { '00' }
        let(:bookable) { 'Y' }
        let(:booking_hours) { 'A' }
        let(:privileges) { CirculationPolicy::Privileges.new(row) }
        before do
          allow(row).to receive(:loanable).and_return(loanable)
          allow(row).to receive(:renewable).and_return(renewable)
          allow(row).to receive(:requestable).and_return(requestable)
          allow(row).to receive(:photocopyable).and_return(photocopyable)
          allow(row).to receive(:displayable).and_return(displayable)
          allow(row).to receive(:specific_item).and_return(specific_item)
          allow(row).to receive(:limit_hold).and_return(limit_hold)
          allow(row).to receive(:recallable).and_return(recallable)
          allow(row).to receive(:rush_recallable).and_return(photocopyable)
          allow(row).to receive(:reloaning_limit).and_return(rush_recallable)
          allow(row).to receive(:bookable).and_return(bookable)
          allow(row).to receive(:booking_hours).and_return(booking_hours)
        end
        subject(:circulation_policy) { CirculationPolicy.new(identifier, display, privileges) }
        it { should be_a CirculationPolicy }
        describe '#identifier' do
          subject { circulation_policy.identifier }
          it { should eq identifier }
        end
        describe '#display' do
          subject { circulation_policy.display }
          it { should eq display }
        end
        describe '#privileges' do
          subject { circulation_policy.privileges }
          it { should eq privileges }
        end
        describe '#==' do
          subject { circulation_policy == other_object }
          context 'when the other object is an Item::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { circulation_policy === other_object }
          context 'when the other object is an Item::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { circulation_policy.eql?(other_object) }
          context 'when the other object is an Item::CirculationPolicy' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationPolicy.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationPolicy::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationPolicy' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        context 'when initialized with arguments' do
          context 'but the "identifier" argument is not an Item::CirculationPolicy::Identifier' do
            let(:identifier) { "invalid" }
            it 'should raise an ArgumentError' do
              expect { subject }.to raise_error ArgumentError
            end
          end
          context 'and the "identifier" argument is an Item::CirculationPolicy::Identifier' do
            context 'but the "display" argument is not an Item::CirculationPolicy::Display' do
              let(:display) { "invalid" }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'and the "display" argument is an Item::CirculationPolicy::Display' do
              context 'but the "privileges" argument is not a Item::CirculationPolicy::Privileges' do
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
end
