require 'spec_helper'
module Exlibris
  module Aleph
    module Rest
      class Patron
        describe Address, vcr: { cassette_name: 'patron', record: :new_episodes } do
          let(:patron_id) { 'BOR_ID' }
          subject(:address) { Address.new(patron_id) }
          it { should be_a Address }
          describe '#patron_id' do
            subject { address.patron_id }
            it { should eq patron_id }
          end
          describe '#reply_code' do
            subject { address.reply_code }
            it { should eq '0000' }
          end
          describe '#reply_text' do
            subject { address.reply_text }
            it { should eq 'ok' }
          end
        end
      end
    end
  end
end
