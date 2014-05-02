require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        describe Privileges do
          let(:row) { double }
          let(:borrow) { 'Y' }
          let(:photocopy) { 'Y' }
          let(:request) { 'Y' }
          let(:request_multiple) { 'Y' }
          let(:request_on_shelf) { 'Y' }
          let(:renew) { 'Y' }
          let(:book) { 'Y' }
          let(:rush_cataloging) { 'Y' }
          before do
            allow(row).to receive(:borrow).and_return(borrow)
            allow(row).to receive(:photocopy).and_return(photocopy)
            allow(row).to receive(:request).and_return(request)
            allow(row).to receive(:request_multiple).and_return(request_multiple)
            allow(row).to receive(:request_on_shelf).and_return(request_on_shelf)
            allow(row).to receive(:renew).and_return(renew)
            allow(row).to receive(:book).and_return(book)
            allow(row).to receive(:rush_cataloging).and_return(rush_cataloging)
          end
          subject(:privileges) { Privileges.new(row) }
          it { should be_a Privileges }
          describe '#borrow' do
            subject { privileges.borrow }
            it { should eq borrow }
          end
          describe '#can_borrow?' do
            subject { privileges.can_borrow? }
            it { should be_true }
            context 'when the patron cannot borrow' do
              let(:borrow) { 'N' }
              it { should be_false }
            end
          end
          describe '#photocopy' do
            subject { privileges.photocopy }
            it { should eq photocopy }
          end
          describe '#can_photocopy?' do
            subject { privileges.can_photocopy? }
            it { should be_true }
            context 'when the patron cannot photocopy' do
              let(:photocopy) { 'N' }
              it { should be_false }
            end
          end
          describe '#request' do
            subject { privileges.request }
            it { should eq request }
          end
          describe '#can_request?' do
            subject { privileges.can_request? }
            it { should be_true }
            context 'when the patron cannot request' do
              let(:request) { 'N' }
              it { should be_false }
            end
          end
          describe '#request_multiple' do
            subject { privileges.request_multiple }
            it { should eq request_multiple }
          end
          describe '#can_request_multiple?' do
            subject { privileges.can_request_multiple? }
            it { should be_true }
            context 'when the patron cannot request multiple items' do
              let(:request_multiple) { 'N' }
              it { should be_false }
            end
          end
          describe '#request_on_shelf' do
            subject { privileges.request_on_shelf }
            it { should eq request_on_shelf }
          end
          describe '#can_request_on_shelf?' do
            subject { privileges.can_request_on_shelf? }
            it { should be_true }
            context 'when the patron cannot request on shelf items' do
              let(:request_on_shelf) { 'N' }
              it { should be_false }
            end
          end
          describe '#renew' do
            subject { privileges.renew }
            it { should eq renew }
          end
          describe '#can_renew?' do
            subject { privileges.can_renew? }
            it { should be_true }
            context 'when the patron cannot renew items' do
              let(:renew) { 'N' }
              it { should be_false }
            end
          end
          describe '#book' do
            subject { privileges.book }
            it { should eq book }
          end
          describe '#can_book?' do
            subject { privileges.can_book? }
            it { should be_true }
            context 'when the patron cannot book items' do
              let(:book) { 'N' }
              it { should be_false }
            end
          end
          describe '#rush_cataloging' do
            subject { privileges.rush_cataloging }
            it { should eq rush_cataloging }
          end
          describe '#can_rush_cataloging?' do
            subject { privileges.can_rush_cataloging? }
            it { should be_true }
            context 'when the patron cannot rush cataloging' do
              let(:rush_cataloging) { 'N' }
              it { should be_false }
            end
          end
        end
      end
    end
  end
end
