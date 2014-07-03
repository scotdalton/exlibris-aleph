require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        describe Patron, vcr: {cassette_name: 'patron'} do
          let(:id) { 'BOR_ID' }
          subject(:patron) { Patron.new(id) }
          it { should be_a Patron }
          describe '#id' do
            subject { patron.id }
            it { should eq id }
          end
          describe '#reply_code' do
            subject { patron.reply_code }
            it { should eq '0000' }
          end
          describe '#reply_text' do
            subject { patron.reply_text }
            it { should eq 'ok' }
          end
          describe '#error?' do
            subject { patron.error? }
            it { should be_false }
          end
          describe '#to_h' do
            subject { patron.to_h }
            it { should be_a Hash }
          end
          describe '#to_xml' do
            subject { patron.to_xml }
            it { should be_a String }
          end
        end
      end
    end
  end
end
