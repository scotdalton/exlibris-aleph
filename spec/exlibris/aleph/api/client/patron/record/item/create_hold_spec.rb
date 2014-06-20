require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              describe Hold, vcr: {cassette_name: 'patron'} do
                let(:patron_id) { 'BOR_ID' }
                let(:record_id) { 'NYU01002296594' }
                let(:item_id) { 'NYU50002296594000010' }
                let(:pickup_location) do
                  Exlibris::Aleph::PickupLocation.new('BOBST', 'NYU Bobst')
                end
                let(:parameters) do
                  CreateHold::Parameters.new({pickup_location: pickup_location})
                end
                subject(:create_hold) do
                  CreateHold.new(patron_id, record_id, item_id, parameters)
                end
                describe '#patron_id' do
                  subject { create_hold.patron_id }
                  it { should eq patron_id }
                end
                describe '#record_id' do
                  subject { create_hold.record_id }
                  it { should eq record_id }
                end
                describe '#item_id' do
                  subject { create_hold.item_id }
                  it { should eq item_id }
                end
                describe '#reply_code' do
                  subject { create_hold.reply_code }
                  it { should eq '0000' }
                end
                describe '#reply_text' do
                  subject { create_hold.reply_text }
                  it { should eq 'ok' }
                end
                describe '#error?' do
                  subject { create_hold.error? }
                  it { should be_false }
                end
                describe '#to_h' do
                  subject { create_hold.to_h }
                  it { should be_a Hash }
                end
                describe '#to_xml' do
                  subject { create_hold.to_xml }
                  it { should be_a String }
                end
                context 'when the patron does not have permissions place a hold on the item' do
                  let(:patron_id) { 'BOR_ID_WITHOUT_HOLD_PERMISSION' }
                  describe '#patron_id' do
                    subject { create_hold.patron_id }
                    it { should eq patron_id }
                  end
                  describe '#record_id' do
                    subject { create_hold.record_id }
                    it { should eq record_id }
                  end
                  describe '#item_id' do
                    subject { create_hold.item_id }
                    it { should eq item_id }
                  end
                  describe '#reply_code' do
                    subject { create_hold.reply_code }
                    it { should eq '0025' }
                  end
                  describe '#reply_text' do
                    subject { create_hold.reply_text }
                    it { should eq 'Failed to create request' }
                  end
                  describe '#error?' do
                    subject { create_hold.error? }
                    it { should be_true }
                  end
                  describe '#to_h' do
                    subject { create_hold.to_h }
                    it { should be_a Hash }
                  end
                  describe '#to_xml' do
                    subject { create_hold.to_xml }
                    it { should be_a String }
                  end
                end
                context 'when the parameters argument is not a Parameters' do
                  let(:parameters) { 'invalid' }
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
  end
end
