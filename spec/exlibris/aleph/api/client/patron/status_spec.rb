require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          describe Status, vcr: { cassette_name: 'patron', record: :new_episodes } do
            let(:patron_id) { 'BOR_ID' }
            subject(:status) { Status.new(patron_id) }
            it { should be_a Status }
            describe '#patron_id' do
              subject { status.patron_id }
              it { should eq patron_id }
            end
            describe '#reply_code' do
              subject { status.reply_code }
              it { should eq '0000' }
            end
            describe '#reply_text' do
              subject { status.reply_text }
              it { should eq 'ok' }
            end
            describe '#error?' do
              subject { status.error? }
              it { should be_false }
            end
            describe '#to_h' do
              subject { status.to_h }
              it { should be_a Hash }
            end
            describe '#to_xml' do
              subject { status.to_xml }
              it { should be_a String }
            end
          end
        end
      end
    end
  end
end
