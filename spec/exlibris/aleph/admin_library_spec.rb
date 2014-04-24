require 'spec_helper'
module Exlibris
  module Aleph
    describe AdminLibrary do
      let(:code) { 'ADM50' }
      subject(:admin_library) { AdminLibrary.new(code) }
      it { should be_a AdminLibrary }
      describe '#code' do
        subject { admin_library.code }
        it { should eq code }
      end
      describe '#normalized_code' do
        subject { admin_library.normalized_code }
        it { should eq code.downcase }
      end
      describe '#display' do
        subject { admin_library.display }
        xit { should eq 'Admin Library' }
      end
      describe '#==' do
        subject { admin_library == other_object }
        context 'when the other object is an Exlibris::Aleph::AdminLibrary' do
          context 'and the code is the same' do
            let(:other_object) { AdminLibrary.new(code) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { AdminLibrary.new("ADM51") }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::AdminLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#===' do
        subject { admin_library === other_object }
        context 'when the other object is an Exlibris::Aleph::AdminLibrary' do
          context 'and the code is the same' do
            let(:other_object) { AdminLibrary.new(code) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { AdminLibrary.new("ADM51") }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::AdminLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#eql?' do
        subject { admin_library.eql?(other_object) }
        context 'when the other object is an Exlibris::Aleph::AdminLibrary' do
          context 'and the code is the same' do
            let(:other_object) { AdminLibrary.new(code) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { AdminLibrary.new("ADM51") }
            it { should be_false }
          end
        end
        context 'when the other object is not an Exlibris::Aleph::AdminLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#hash' do
        subject { admin_library.hash }
        it { should eq code.hash }
      end
      context 'when initialized with a code argument that is not a String' do
        let(:code) { Hash.new }
        it 'should raise an ArgumentError' do
          expect { subject }.to raise_error ArgumentError
        end
      end
    end
  end
end
