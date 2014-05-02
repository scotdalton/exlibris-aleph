require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe Address, vcr: { cassette_name: 'patron', record: :new_episodes } do
        let(:patron_id) { 'BOR_ID' }
        subject(:address) { Address.new(patron_id) }
        it { should be_an Address }
        describe '#patron_id' do
          subject { address.patron_id }
        end
      end
    end
  end
end
