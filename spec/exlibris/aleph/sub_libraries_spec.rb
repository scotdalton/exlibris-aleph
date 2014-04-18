require 'spec_helper'
module Exlibris
  module Aleph
    describe SubLibraries do
      subject(:sub_libraries) { SubLibraries.instance }
      describe '#all' do
        subject { sub_libraries.all }
        it { should be_an Array }
        it { should_not be_empty }
      end
      describe '#each' do
        subject { sub_libraries.each }
        it { should be_an Enumerable }
      end
      describe '#equal?' do
        let(:other_instance) { SubLibraries.instance }
        subject { sub_libraries.equal?(other_instance) }
        it { should be_true }
      end
    end
  end
end
