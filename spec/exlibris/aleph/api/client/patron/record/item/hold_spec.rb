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
                let(:record_id) { 'NYU01000864162' }
                let(:item_id) { 'NYU50000864162000010' }
                subject(:hold) { Hold.new(patron_id, record_id, item_id) }
                it { should be_a Hold }
                describe '#patron_id' do
                  subject { hold.patron_id }
                  it { should eq patron_id }
                end
                describe '#record_id' do
                  subject { hold.record_id }
                  it { should eq record_id }
                end
                describe '#item_id' do
                  subject { hold.item_id }
                  it { should eq item_id }
                end
                describe '#reply_code' do
                  subject { hold.reply_code }
                  it { should eq '0000' }
                end
                describe '#reply_text' do
                  subject { hold.reply_text }
                  it { should eq 'ok' }
                end
                describe '#error?' do
                  subject { hold.error? }
                  it { should be_false }
                end
                describe '#to_h' do
                  subject { hold.to_h }
                  it { should be_a Hash }
                end
                describe '#to_xml' do
                  subject { hold.to_xml }
                  it { should be_a String }
                end
                context 'when the patron does not have permissions place a hold on the item' do
                  let(:patron_id) { 'BOR_ID_WITHOUT_HOLD_PERMISSION' }
                  describe '#patron_id' do
                    subject { hold.patron_id }
                    it { should eq patron_id }
                  end
                  describe '#record_id' do
                    subject { hold.record_id }
                    it { should eq record_id }
                  end
                  describe '#item_id' do
                    subject { hold.item_id }
                    it { should eq item_id }
                  end
                  describe '#reply_code' do
                    subject { hold.reply_code }
                    it { should eq '0000' }
                  end
                  describe '#reply_text' do
                    subject { hold.reply_text }
                    it { should eq 'ok' }
                  end
                  describe '#error?' do
                    subject { hold.error? }
                    it { should be_false }
                  end
                  describe '#to_h' do
                    subject { hold.to_h }
                    it { should be_a Hash }
                  end
                  describe '#to_xml' do
                    subject { hold.to_xml }
                    it { should be_a String }
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
