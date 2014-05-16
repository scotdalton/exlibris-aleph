require 'spec_helper'
module Exlibris
  module Aleph
    class Patron
      describe Record, vcr: { cassette_name: 'patron', record: :new_episodes } do
        let(:patron_id) { 'BOR_ID' }
        let(:id) { 'NYU01000980206' }
        subject(:record) { Record.new(patron_id, id) }
        it { should be_an Record }
        describe '#patron_id' do
          subject { record.patron_id }
          it { should eq patron_id }
        end
        describe '#id' do
          subject { record.id }
          it { should eq id }
        end
        describe '#circulation_policy' do
          subject { record.circulation_policy }
          it { should be_a Record::CirculationPolicy }
        end
        describe '#item' do
          let(:item_id) { 'NYU50001951476001220' }
          subject { record.item(item_id) }
          it { should be_a Record::Item }
        end
      end
    end
  end
end
