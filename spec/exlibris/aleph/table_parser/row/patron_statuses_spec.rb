require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Row
        describe PatronStatuses do
          let(:data) { ['Palmer Faculty                                     ', '03'] }
          subject(:patron_statuses) { PatronStatuses.new(data) }
          it { should be_a Base }
          it { should be_a PatronStatuses }
          describe '#data' do
            subject { patron_statuses.data }
            it { should eq data }
          end
          describe '#code' do
            subject { patron_statuses.code }
            it { should eq '03' }
          end
          describe '#display' do
            subject { patron_statuses.display }
            it { should eq 'Palmer Faculty' }
          end
        end
      end
    end
  end
end
