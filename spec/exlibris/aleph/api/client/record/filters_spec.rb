require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Record
          describe Filters, vcr: {cassette_name: 'record', record: :new_episodes} do
            let(:record_id) { 'NYU01000980206' }
            let(:view) { 'full' }
            let(:query) { { view: view } }
            subject(:filters) { Filters.new(record_id, query) }
            it { should be_a Filters }
            describe '#id' do
              subject { filters.record_id }
              it { should eq record_id }
            end
            describe '#reply_code' do
              subject { filters.reply_code }
              it { should eq '0000' }
            end
            describe '#reply_text' do
              subject { filters.reply_text }
              it { should eq 'ok' }
            end
            describe '#error?' do
              subject { filters.error? }
              it { should be_false }
            end
            describe '#to_h' do
              subject { filters.to_h }
              it { should be_a Hash }
            end
            describe '#to_xml' do
              subject { filters.to_xml }
              it { should be_a String }
            end
            context 'when initialized without a "query" argument' do
              subject { Filters.new(record_id) }
              it { should be_a Filters }
            end
          end
        end
      end
    end
  end
end
