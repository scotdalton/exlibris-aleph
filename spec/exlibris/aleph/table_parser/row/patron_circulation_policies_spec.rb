require 'spec_helper'
module Exlibris
  module Aleph
    module TableParser
      module Row
        describe PatronCirculationPolicies do
          let(:data) { ['BOBST', '03', 'Y', 'N', 'Y', 'N', 'Y', 'Y', 'Y', 'N',
            'F', 'A', ' ', '20130831', '0000000500', 'N', 'N', 'N', '20', 'N',
            'N', 'N', 'N'] }
          subject(:patron_circulation_policies) { PatronCirculationPolicies.new(data) }
          it { should be_a Base }
          it { should be_a PatronCirculationPolicies }
          describe '#data' do
            subject { patron_circulation_policies.data }
            it { should eq data }
          end
          describe '#sub_library_code' do
            subject { patron_circulation_policies.sub_library_code }
            it { should eq 'BOBST' }
          end
          describe '#patron_status_code' do
            subject { patron_circulation_policies.patron_status_code }
            it { should eq '03' }
          end
          describe '#borrow' do
            subject { patron_circulation_policies.borrow }
            it { should eq 'Y' }
          end
          describe '#photocopy' do
            subject { patron_circulation_policies.photocopy }
            it { should eq 'N' }
          end
          describe '#override' do
            subject { patron_circulation_policies.override }
            it { should eq 'Y' }
          end
          describe '#request_multiple' do
            subject { patron_circulation_policies.request_multiple }
            it { should eq 'N' }
          end
          describe '#check_loan' do
            subject { patron_circulation_policies.check_loan }
            it { should eq 'Y' }
          end
          describe '#request' do
            subject { patron_circulation_policies.request }
            it { should eq 'Y' }
          end
          describe '#renew' do
            subject { patron_circulation_policies.renew }
            it { should eq 'Y' }
          end
          describe '#ignore_late_return' do
            subject { patron_circulation_policies.ignore_late_return }
            it { should eq 'N' }
          end
          describe '#photocopy_charge' do
            subject { patron_circulation_policies.photocopy_charge }
            it { should eq 'F' }
          end
          describe '#expiration_date_operator' do
            subject { patron_circulation_policies.expiration_date_operator }
            it { should eq 'A' }
          end
          describe '#expiration_date_operator_type' do
            subject { patron_circulation_policies.expiration_date_operator_type }
            it { should eq '' }
          end
          describe '#expiration_date_parameter' do
            subject { patron_circulation_policies.expiration_date_parameter }
            it { should eq '20130831' }
          end
          describe '#cash_overspend_limit' do
            subject { patron_circulation_policies.cash_overspend_limit }
            it { should eq '0000000500' }
          end
          describe '#request_on_shelf' do
            subject { patron_circulation_policies.request_on_shelf }
            it { should eq 'N' }
          end
          describe '#loan_display' do
            subject { patron_circulation_policies.loan_display }
            it { should eq 'N' }
          end
          describe '#reading_room_permission' do
            subject { patron_circulation_policies.reading_room_permission }
            it { should eq 'N' }
          end
          describe '#default_hold_priority' do
            subject { patron_circulation_policies.default_hold_priority }
            it { should eq '20' }
          end
          describe '#book' do
            subject { patron_circulation_policies.book }
            it { should eq 'N' }
          end
          describe '#ignore_closing_hours_for_booking' do
            subject { patron_circulation_policies.ignore_closing_hours_for_booking }
            it { should eq 'N' }
          end
          describe '#automatically_create_aleph_record' do
            subject { patron_circulation_policies.automatically_create_aleph_record }
            it { should eq 'N' }
          end
          describe '#rush_cataloging' do
            subject { patron_circulation_policies.rush_cataloging }
            it { should eq 'N' }
          end
        end
      end
    end
  end
end
