require 'spec_helper'
module Exlibris
  module Aleph
    module Rest
      class Record
        describe Holdings, vcr: { cassette_name: 'record', record: :new_episodes } do
          let(:record_id) { 'NYU01000980206' }
          let(:view) { 'full' }
          let(:query) { { view: view } }
          subject(:holdings) { Holdings.new(record_id, query) }
          it { should be_a Holdings }
          describe '#id' do
            subject { holdings.record_id }
            it { should eq record_id }
          end
          describe '#reply_code' do
            subject { holdings.reply_code }
            it { should eq '0000' }
          end
          describe '#reply_text' do
            subject { holdings.reply_text }
            it { should eq 'ok' }
          end
          describe 'error?' do
            subject { holdings.error? }
            it { should be_false }
          end
          describe '#to_h' do
            subject { holdings.to_h }
            it { should be_a Hash }
          end
          describe '#to_xml' do
            subject { holdings.to_xml }
            it { should be_a String }
          end
          context 'when initialized without a "query" argument' do
            subject { Holdings.new(record_id) }
            it { should be_a Holdings }
          end
        end
      end
    end
  end
end
