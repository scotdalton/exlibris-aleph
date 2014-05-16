require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        describe Patron do
          let(:root) do
            {
              'patron' => {
                'translate_change_active_library' => 'NYU50'
              }
            }
          end
          subject(:patron) { Patron.new(root) }
          it { should be_a Patron }
          describe '#root' do
            subject { patron.root }
            it { should eq root }
          end
          describe '#admin_library_code' do
            subject { patron.admin_library_code }
            it { should eql 'NYU50'}
          end
        end
      end
    end
  end
end
