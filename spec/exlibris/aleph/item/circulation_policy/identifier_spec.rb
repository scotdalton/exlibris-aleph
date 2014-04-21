require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      class CirculationPolicy
        describe Identifier do
          let(:status_code) { '##' }
          let(:status) { Status.new(status_code) }
          let(:processing_status_code) { 'DP' }
          let(:processing_status) { ProcessingStatus.new(processing_status_code) }
          let(:admin_library) { AdminLibrary.new('ADM50') }
          let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
          subject(:identifier) { Identifier.new(status, processing_status, sub_library) }
          it { should be_a Identifier }
          describe '#status' do
            subject { identifier.status }
            it { should be_a Status }
            it { should eq status }
          end
          describe '#processing_status' do
            subject { identifier.processing_status }
            it { should be_a ProcessingStatus }
            it { should eq processing_status }
          end
          describe '#sub_library' do
            subject { identifier.sub_library }
            it { should be_a SubLibrary }
            it { should eq sub_library }
          end
          describe '#==' do
            subject { identifier == other_object }
            context 'when the other object is an Item::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_processing_status) { processing_status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_processing_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('01') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the processing status of the other object is different' do
                  let(:other_processing_status) { ProcessingStatus.new('##') }
                  it { should be_false }
                end
                context 'and the processing status of the other object is the same' do
                  context 'but the sub library of the other object is different' do
                    let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                    it { should be_false }
                  end
                  context 'and the sub library of the other object is the same' do
                    it { should be_true }
                  end
                end
              end
            end
            context 'when the other object is not an Item::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          describe '#===' do
            subject { identifier === other_object }
            context 'when the other object is an Item::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_processing_status) { processing_status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_processing_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('01') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the processing status of the other object is different' do
                  let(:other_processing_status) { ProcessingStatus.new('##') }
                  it { should be_false }
                end
                context 'and the processing status of the other object is the same' do
                  context 'but the sub library of the other object is different' do
                    let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                    it { should be_false }
                  end
                  context 'and the sub library of the other object is the same' do
                    it { should be_true }
                  end
                end
              end
            end
            context 'when the other object is not an Item::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          describe '#eql?' do
            subject { identifier.eql?(other_object) }
            context 'when the other object is an Item::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_processing_status) { processing_status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_processing_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('01') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the processing status of the other object is different' do
                  let(:other_processing_status) { ProcessingStatus.new('##') }
                  it { should be_false }
                end
                context 'and the processing status of the other object is the same' do
                  context 'but the sub library of the other object is different' do
                    let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                    it { should be_false }
                  end
                  context 'and the sub library of the other object is the same' do
                    it { should be_true }
                  end
                end
              end
            end
            context 'when the other object is not an Item::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          context 'when initialized with arguments' do
            context 'but the "status" argument is not an Item::Status' do
              let(:status) { "invalid" }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'and the "status" argument is an Item::Status' do
              context 'but the "processing status" argument is not an Item::ProcessingStatus' do
                let(:processing_status) { "invalid" }
                it 'should raise an ArgumentError' do
                  expect { subject }.to raise_error ArgumentError
                end
              end
              context 'and the "processing status" argument is an Item::ProcessingStatus' do
                context 'but the "sub library" argument is not a SubLibrary' do
                  let(:sub_library) { "invalid" }
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
end
