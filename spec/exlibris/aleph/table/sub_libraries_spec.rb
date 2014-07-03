require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      describe SubLibraries do
        subject(:sub_libraries) { SubLibraries.new }
        describe '#all' do
          subject { sub_libraries.all }
          it { should be_an Array }
          it { should_not be_empty }
        end
        describe '#each' do
          subject { sub_libraries.each }
          it { should be_an Enumerable }
        end
      end
    end
  end
end
