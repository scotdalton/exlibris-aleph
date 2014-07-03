require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            describe Item, vcr: {cassette_name: 'patron', record: :new_episodes} do
              let(:patron_id) { 'BOR_ID' }
              let(:record_id) { 'NYU01000980206' }
              let(:id) { 'NYU50001951476001220' }
              subject(:item) { Item.new(patron_id, record_id, id) }
              it { should be_a Item }
              describe '#patron_id' do
                subject { item.patron_id }
                it { should eq patron_id }
              end
              describe '#record_id' do
                subject { item.record_id }
                it { should eq record_id }
              end
              describe '#id' do
                subject { item.id }
                it { should eq id }
              end
              describe '#reply_code' do
                subject { item.reply_code }
                it { should eq '0000' }
              end
              describe '#reply_text' do
                subject { item.reply_text }
                it { should eq 'ok' }
              end
              describe '#error?' do
                subject { item.error? }
                it { should be_false }
              end
              describe '#to_h' do
                subject { item.to_h }
                it { should be_a Hash }
              end
              describe '#to_xml' do
                subject { item.to_xml }
                it { should be_a String }
              end
            end
          end
        end
      end
    end
  end
end
