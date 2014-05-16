require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Patron
        describe Statuses do
          subject(:statuses) { Statuses.new }
          describe '#all' do
            subject { statuses.all }
            it { should be_an Hash }
            it { should_not be_empty }
          end
          describe '#each' do
            subject { statuses.each }
            it { should be_an Enumerable }
          end
          describe '#[]' do
            let(:admin_library) { AdminLibrary.new('NYU50') }
            subject { statuses[admin_library] }
            it { should be_an Array }
          end
        end
      end
    end
  end
end
