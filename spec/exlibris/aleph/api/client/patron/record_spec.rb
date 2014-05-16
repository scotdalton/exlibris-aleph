require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          describe Record, vcr: { cassette_name: 'patron', record: :new_episodes } do
            let(:patron_id) { 'BOR_ID' }
            let(:id) { 'NYU01000980206' }
            subject(:record) { Record.new(patron_id, id) }
            it { should be_a Record }
            describe '#patron_id' do
              subject { record.patron_id }
              it { should eq patron_id }
            end
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
            describe '#error?' do
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
          end
        end
      end
    end
  end
end
