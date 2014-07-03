require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        describe Identifier do
          let(:status) { Status.new('01', 'Patron') }
          let(:admin_library) { AdminLibrary.new('ADM50') }
          let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
          subject(:identifier) { Identifier.new(status, sub_library) }
          it { should be_a Identifier }
          describe '#sub_library' do
            subject { identifier.sub_library }
            it { should eq sub_library }
          end
          describe '#status' do
            subject { identifier.status }
            it { should eq status }
          end
          describe '#==' do
            subject { identifier == other_object }
            context 'when the other object is an Patron::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('02', 'Patron') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the sub library of the other object is different' do
                  let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                  it { should be_false }
                end
                context 'and the sub library of the other object is the same' do
                  it { should be_true }
                end
              end
            end
            context 'when the other object is not an Patron::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          describe '#===' do
            subject { identifier === other_object }
            context 'when the other object is an Patron::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('02', 'Patron') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the sub library of the other object is different' do
                  let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                  it { should be_false }
                end
                context 'and the sub library of the other object is the same' do
                  it { should be_true }
                end
              end
            end
            context 'when the other object is not an Patron::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          describe '#eql?' do
            subject { identifier.eql?(other_object) }
            context 'when the other object is an Patron::CirculationPolicy::Identifier' do
              let(:other_status) { status }
              let(:other_sub_library) { sub_library }
              let(:other_object) { Identifier.new(other_status, other_sub_library) }
              context 'but the status of the other object is different' do
                let(:other_status) { Status.new('02', 'Patron') }
                it { should be_false }
              end
              context 'and the status of the other object is the same' do
                context 'but the sub library of the other object is different' do
                  let(:other_sub_library) { SubLibrary.new('SUB1', 'Sub Library 1', admin_library) }
                  it { should be_false }
                end
                context 'and the sub library of the other object is the same' do
                  it { should be_true }
                end
              end
            end
            context 'when the other object is not an Patron::CirculationPolicy::Identifier' do
              let(:other_object) { "invalid" }
              it { should be_false }
            end
          end
          context 'when initialized with arguments' do
            context 'but the "status" argument is not an Patron::Status' do
              let(:status) { "invalid" }
              it 'should raise an ArgumentError' do
                expect { subject }.to raise_error ArgumentError
              end
            end
            context 'and the "status" argument is an Patron::Status' do
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
