require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Record
          describe Item, vcr: { cassette_name: 'record', record: :new_episodes } do
            let(:record_id) { 'NYU01000980206' }
            let(:id) { 'NYU50001951476001220' }
            subject(:item) { Item.new(record_id, id) }
            it { should be_a Item }
            describe '#id' do
              subject { item.record_id }
              it { should eq record_id }
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
