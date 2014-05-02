require 'spec_helper'
module Exlibris
  module Aleph
    describe Holdings, vcr: { cassette_name: 'record', record: :new_episodes } do
      let(:record_id) { 'NYU01000864162' }
      subject(:holdings) { Holdings.new(record_id) }
      it { should be_an Holdings }
      describe '#record_id' do
        subject { holdings.record_id }
        it { should eq record_id }
      end
      describe '#to_a' do
        subject { holdings.to_a }
        it { should be_an Array }
        it 'should contain Holdings' do
          subject.each do |holding|
            expect(holding).to be_a Holding
          end
        end
      end
    end
  end
end
