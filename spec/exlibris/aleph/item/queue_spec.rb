require 'spec_helper'
module Exlibris
  module Aleph
    class Item
      describe Queue do
        let(:value) { "1 request(s) of 1 items." }
        subject(:queue) { Queue.new(value) }
        describe '#value' do
          subject { queue.value }
          it { should eq value }
        end
        describe '#to_s' do
          subject { queue.to_s }
          it { should eq value }
        end
        describe '#number_of_requests' do
          subject { queue.number_of_requests }
          it { should eq 1 }
          context 'when the input value is nil' do
            let(:value) { nil }
            it { should eq 0 }
          end
          context 'when the input value is blank' do
            let(:value) { '' }
            it { should eq 0 }
          end
        end
      end
    end
  end
end
