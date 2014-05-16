require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        describe Base do
          let(:root) { [1, 2] }
          subject(:base) { Base.new(root) }
          it { should be_a Base }
          describe '#root' do
            subject { base.root }
            it { should eq root }
          end
        end
      end
    end
  end
end
