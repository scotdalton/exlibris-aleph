require 'spec_helper'
module Exlibris
  module Aleph
    describe Collections do
      subject(:collections) { Collections.instance }
      describe '#all' do
        subject { collections.all }
        it { should be_an Hash }
        it { should_not be_empty }
      end
      describe '#each' do
        subject { collections.each }
        it { should be_an Enumerable }
      end
      describe '#[]' do
        let(:admin_library) { AdminLibrary.new('NYU50') }
        subject { collections[admin_library] }
        it { should be_an Array }
      end
      describe '#equal?' do
        let(:other_instance) { Collections.instance }
        subject { collections.equal?(other_instance) }
        it { should be_true }
      end
    end
  end
end
