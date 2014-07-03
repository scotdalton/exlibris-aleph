require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          describe Base do
            let(:data) { ['value1', 'value2'] }
            subject(:base) { Base.new(data) }
            it { should be_a Base }
            describe '#data' do
              subject { base.data }
              it { should eq data }
            end
          end
        end
      end
    end
  end
end
