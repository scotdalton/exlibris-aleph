require 'spec_helper'
module Exlibris
  module Aleph
    module Rest
      describe Record, vcr: { cassette_name: 'record' } do
        let(:id) { 'NYU01000980206' }
        let(:query) { { view: 'full' } }
        subject(:record) { Record.new(id, query) }
        it { should be_a Record }
        describe '#id' do
          subject { record.id }
          it { should eq id }
        end
        describe '#reply_code' do
          subject { record.reply_code }
          it { should eq '0000' }
        end
        describe '#reply_text' do
          subject { record.reply_text }
          it { should eq 'ok' }
        end
        describe 'error?' do
          subject { record.error? }
          it { should be_false }
        end
        describe '#to_h' do
          subject { record.to_h }
          it { should be_a Hash }
        end
        describe '#to_xml' do
          subject { record.to_xml }
          it { should be_a String }
        end
        context 'when initialized without a "query" argument' do
          subject { Record.new(id) }
          it { should be_a Record }
        end
      end
    end
  end
end
