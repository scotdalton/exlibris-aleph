require 'spec_helper'
module Exlibris
  module Aleph
    module Rest
      class Record
        describe Items, vcr: { cassette_name: 'record', record: :new_episodes } do
          let(:record_id) { 'NYU01000980206' }
          let(:view) { 'full' }
          let(:query) { { view: view } }
          subject(:items) { Items.new(record_id, query) }
          it { should be_a Items }
          describe '#id' do
            subject { items.record_id }
            it { should eq record_id }
          end
          describe '#reply_code' do
            subject { items.reply_code }
            it { should eq '0000' }
          end
          describe '#reply_text' do
            subject { items.reply_text }
            it { should eq 'ok' }
          end
          describe 'error?' do
            subject { items.error? }
            it { should be_false }
          end
          describe '#to_h' do
            subject { items.to_h }
            it { should be_a Hash }
          end
          describe '#to_xml' do
            subject { items.to_xml }
            it { should be_a String }
          end
          context 'when initialized without a "query" argument' do
            subject { Items.new(record_id) }
            it { should be_a Items }
          end
        end
      end
    end
  end
end
