require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      describe Base do
        subject(:base) { Base.new }
        it { should be_a Base }
        describe '#all' do
          subject { base.all }
          it 'should raise a RuntimeError' do
            expect { subject }.to raise_error RuntimeError
          end
        end
      end
    end
  end
end
