require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Record
          describe Holding, vcr: { cassette_name: 'record', record: :new_episodes } do
            let(:record_id) { 'NYU01000980206' }
            let(:id) { 'NYU60002945614' }
            subject(:holding) { Holding.new(record_id, id) }
            it { should be_a Holding }
            describe '#id' do
              subject { holding.record_id }
              it { should eq record_id }
            end
            describe '#reply_code' do
              subject { holding.reply_code }
              it { should eq '0000' }
            end
            describe '#reply_text' do
              subject { holding.reply_text }
              it { should eq 'ok' }
            end
            describe '#error?' do
              subject { holding.error? }
              it { should be_false }
            end
            describe '#to_h' do
              subject { holding.to_h }
              it { should be_a Hash }
            end
            describe '#to_xml' do
              subject { holding.to_xml }
              it { should be_a String }
            end
          end
        end
      end
    end
  end
end
