require 'spec_helper'
module Exlibris
  module Aleph
    module API
      describe Base do
        subject(:base) { Base.new }
        it { should be_a Base }
        describe '#client' do
          subject { base.send(:client) }
          it 'should raise a RuntimeError' do
            expect { subject }.to raise_error RuntimeError
          end
        end
        describe '#reader' do
          subject { base.send(:reader) }
          it 'should raise a RuntimeError' do
            expect { subject }.to raise_error RuntimeError
          end
        end
      end
    end
  end
end
