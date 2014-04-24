require 'spec_helper'
module Exlibris
  module Aleph
    module Item
      describe DisplayMask do
        let(:value) { 'Display' }
        let(:mask) { 'Display Mask' }
        subject(:display_mask  ) { DisplayMask.new(value, mask) }
        it { should be_a DisplayMask }
        describe '#value' do
          subject { display_mask.value }
          it { should eq value }
        end
        describe '#mask' do
          subject { display_mask.mask }
          it { should eq mask }
        end
        describe '#==' do
          subject { display_mask == other_object }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { DisplayMask.new(value, mask) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { DisplayMask.new('Display 1', 'Display 1 Mask') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#===' do
          subject { display_mask === other_object }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { DisplayMask.new(value, mask) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { DisplayMask.new('Display 1', 'Display 1 Mask') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
        describe '#eql?' do
          subject { display_mask.eql?(other_object) }
          context 'when the other object is an Exlibris::Aleph::Item::DisplayMask' do
            context 'and the value is the same' do
              let(:other_object) { DisplayMask.new(value, mask) }
              it { should be_true }
            end
            context 'but the value is different' do
              let(:other_object) { DisplayMask.new('Display 1', 'Display 1 Mask') }
              it { should be_false }
            end
          end
          context 'when the other object is not an Exlibris::Aleph::Item::DisplayMask' do
            let(:other_object) { "string" }
            it { should be_false }
          end
        end
      end
    end
  end
end
