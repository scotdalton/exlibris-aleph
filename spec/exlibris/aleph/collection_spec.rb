require 'spec_helper'
module Exlibris
  module Aleph
    describe Collection do
      let(:code) { 'MAIN' }
      let(:display) { 'Main Collection' }
      let(:admin_library) { AdminLibrary.new('ADM50') }
      let(:sub_library) { SubLibrary.new('SUB', 'Sub Library', admin_library) }
      subject(:collection) { Collection.new(code, display, sub_library) }
      it { should be_a Collection }
      describe '#code' do
        subject { collection.code }
        it { should eq code }
      end
      describe '#display' do
        subject { collection.display }
        it { should eq display }
      end
      describe '#sub_library' do
        subject { collection.sub_library }
        it { should be_a SubLibrary }
        it { should eq sub_library }
      end
      describe '#to_s' do
        subject { collection.to_s }
        it { should eq display }
      end
      describe '#==' do
        subject { collection == other_object }
        context 'when the other object is an Exlibris::Aleph::Collection' do
          context 'and the code is the same' do
            let(:other_object) { Collection.new(code, display, sub_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { Collection.new('MOBI', 'Mobile', sub_library) }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::Collection' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#===' do
        subject { collection === other_object }
        context 'when the other object is an Exlibris::Aleph::Collection' do
          context 'and the code is the same' do
            let(:other_object) { Collection.new(code, display, sub_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { Collection.new('MOBI', 'Mobile', sub_library) }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::Collection' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#eql?' do
        subject { collection.eql?(other_object) }
        context 'when the other object is an Exlibris::Aleph::Collection' do
          context 'and the code is the same' do
            let(:other_object) { Collection.new(code, display, sub_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { Collection.new('MOBI', 'Mobile', sub_library) }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::Collection' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      context 'when initialized without a "sub_library" argument' do
        subject { Collection.new(code, display) }
        it 'should raise an ArgumentError' do
          expect { subject }.to raise_error ArgumentError
        end
      end
      context 'when initialized with a "sub_library" argument' do
        context 'but the "sub_library" argument is not an SubLibrary' do
          let(:sub_library) { "invalid" }
          it 'should raise an ArgumentError' do
            expect { subject }.to raise_error ArgumentError
          end
        end
      end
    end
  end
end
