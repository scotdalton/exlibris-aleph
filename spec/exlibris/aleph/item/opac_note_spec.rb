require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe OpacNote do
        let(:value) { "Library's copy is predominantly out of order Advertising and Covers from 1936." }
        subject(:opac_note) { OpacNote.new(value) }
        describe '#value' do
          subject { opac_note.value }
          it { should eq value }
        end
        describe '#to_s' do
          subject { opac_note.to_s }
          it { should eq value }
        end
      end
    end
  end
end
