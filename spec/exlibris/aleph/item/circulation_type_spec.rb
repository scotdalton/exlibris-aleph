require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      describe CirculationType do
        let(:status_code) { '##' }
        let(:status) { Status.new(status_code) }
        let(:processing_status_code) { 'DP' }
        let(:processing_status) { ProcessingStatus.new(processing_status_code) }
        let(:admin_library) { AdminLibrary.new('ADM50') }
        let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
        let(:identifier) { CirculationType::Identifier.new(status, processing_status, sub_library) }
        let(:display) { CirculationType::Display.new('Display') }
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
        let(:privileges) { CirculationType::Privileges.new(row) }
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
        subject(:circulation_type) { CirculationType.new(identifier, display, privileges) }
        it { should be_a CirculationType }
        describe '#identifier' do
          subject { circulation_type.identifier }
          it { should eq identifier }
        end
        describe '#display' do
          subject { circulation_type.display }
          it { should eq display }
        end
        describe '#privileges' do
          subject { circulation_type.privileges }
          it { should eq privileges }
        end
        describe '#==' do
          subject { circulation_type == other_object }
          context 'when the other object is an Item::CirculationType' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationType.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationType::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationType' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { circulation_type === other_object }
          context 'when the other object is an Item::CirculationType' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationType.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationType::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationType' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { circulation_type.eql?(other_object) }
          context 'when the other object is an Item::CirculationType' do
            let(:other_identifier) { identifier }
            let(:other_display) { display }
            let(:other_privileges) { privileges }
            let(:other_object) { CirculationType.new(other_identifier, other_display, other_privileges) }
            context 'but the identifier of the other object is different' do
              let(:other_status) { Status.new('01') }
              let(:other_identifier) { CirculationType::Identifier.new(other_status, processing_status, sub_library) }
              it { should be_false }
            end
            context 'and the identifier of the other object is the same' do
              it { should be_true }
            end
          end
          context 'when the other object is not an Item::CirculationType' do
            let(:other_object) { "invalid" }
            it { should be_false }
          end
        end
        context 'when initialized with arguments' do
          context 'but the "identifier" argument is not an Item::CirculationType::Identifier' do
            let(:identifier) { "invalid" }
            it 'should raise an ArgumentError' do
              expect { subject }.to raise_error ArgumentError
            end
          end
          context 'and the "identifier" argument is an Item::CirculationType::Identifier' do
            context 'but the "display" argument is not an Item::CirculationType::Display' do
              let(:display) { "invalid" }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'and the "display" argument is an Item::CirculationType::Display' do
              context 'but the "privileges" argument is not a Item::CirculationType::Privileges' do
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
