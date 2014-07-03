require 'spec_helper'
module Exlibris
  module Aleph
    describe SubLibrary do
      let(:code) { 'SUB' }
      let(:display) { 'Sub Library' }
      let(:admin_library) { AdminLibrary.new('ADM50') }
      subject(:sub_library) { SubLibrary.new(code, display, admin_library) }
      it { should be_a SubLibrary }
      describe '#code' do
        subject { sub_library.code }
        it { should eq code }
      end
      describe '#display' do
        subject { sub_library.display }
        it { should eq display }
      end
      describe '#admin_library' do
        subject { sub_library.admin_library }
        it { should be_an AdminLibrary }
        it { should eq admin_library }
      end
      describe '#to_s' do
        subject { sub_library.to_s }
        it { should eq display }
      end
      describe '#==' do
        subject { sub_library == other_object }
        context 'when the other object is an Exlibris::Aleph::SubLibrary' do
          context 'and the code is the same' do
            let(:other_object) { SubLibrary.new(code, display, admin_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { SubLibrary.new('SUB1', display, admin_library) }
            it { should be_false }
          end
          context 'and the code is the same' do
            context 'but the admin library is different' do
              let(:other_object) { SubLibrary.new(code, display, AdminLibrary.new('ADM51')) }
              it { should be_false }
            end
          end
        end
        context 'when the other object is not an Exlibris::Aleph::SubLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#===' do
        subject { sub_library === other_object }
        context 'when the other object is an Exlibris::Aleph::SubLibrary' do
          context 'and the code is the same' do
            let(:other_object) { SubLibrary.new(code, display, admin_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { SubLibrary.new('SUB1', display, admin_library) }
            it { should be_false }
          end
          context 'and the code is the same' do
            context 'but the admin library is different' do
              let(:other_object) { SubLibrary.new(code, display, AdminLibrary.new('ADM51')) }
              it { should be_false }
            end
          end
        end
        context 'when the other object is not an Exlibris::Aleph::SubLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#eql?' do
        subject { sub_library.eql?(other_object) }
        context 'when the other object is an Exlibris::Aleph::SubLibrary' do
          context 'and the code is the same' do
            let(:other_object) { SubLibrary.new(code, display, admin_library) }
            it { should be_true }
          end
          context 'but the code is different' do
            let(:other_object) { SubLibrary.new('SUB1', display, admin_library) }
            it { should be_false }
          end
          context 'and the code is the same' do
            context 'but the admin library is different' do
              let(:other_object) { SubLibrary.new(code, display, AdminLibrary.new('ADM51')) }
              it { should be_false }
            end
          end
        end
        context 'when the other object is not an Exlibris::Aleph::SubLibrary' do
          let(:other_object) { "string" }
          it { should be_false }
        end
      end
      describe '#hash' do
        subject { sub_library.hash }
        it { should eq code.hash }
      end
      context 'when initialized with an "admin_library" argument' do
        context 'but the "admin_library" argument is not an AdminLibrary' do
          let(:admin_library) { "invalid" }
          it 'should raise an ArgumentError' do
            expect { subject }.to raise_error ArgumentError
          end
        end
      end
    end
  end
end
