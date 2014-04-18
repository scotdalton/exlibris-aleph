require 'spec_helper'
module Exlibris
  module Aleph
    module Rest
      describe Base do
        let(:view) { 'full' }
        let(:query) { { view: view } }
        subject(:base) { Base.new(query) }
        it { should be_a Base }
        describe Base::VALID_VIEWS do
          subject { Base::VALID_VIEWS }
          it { should be_an Array }
          it { should eq ['full', 'brief'] }
        end
        context 'when initialized without a "query" argument' do
          subject(:base) { Base.new }
          it { should be_a Base }
        end
        context 'when initialized with a "query" argument' do
          context 'but the "query" argument is invalid' do
            let(:query) { "invalid" }
            it 'should raise an ArgumentError' do
              expect { subject }.to raise_error ArgumentError
            end
          end
          context 'and the "query" argument is valid' do
            context 'but the view is invalid' do
              let(:view) { 'invalid' }
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
