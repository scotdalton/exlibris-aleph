require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        describe PatronStatuses do
          let(:admin_library) { AdminLibrary.new('NYU50') }
          subject(:patron_statuses) { PatronStatuses.new(admin_library) }
          describe '#filename' do
            subject { patron_statuses.filename }
            it { should eq 'pc_tab_exp_field_extended.eng' }
          end
          describe '#all' do
            subject { patron_statuses.all }
            it { should be_an Array }
            it { should_not be_empty }
            it 'should contain Patron::Status' do
              subject.each do |patron_status|
                expect(patron_status).to be_a Aleph::Patron::Status
              end
            end
          end
        end
      end
    end
  end
end
