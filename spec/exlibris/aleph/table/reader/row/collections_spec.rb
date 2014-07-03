require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          describe Collections do
            let(:data) { ['MAIN', 'BOBST', 'L', 'Main Collection'] }
            subject(:collections) { Collections.new(data) }
            it { should be_a Base }
            it { should be_a Collections }
            describe '#data' do
              subject { collections.data }
              it { should eq data }
            end
            describe '#code' do
              subject { collections.code }
              it { should eq 'MAIN' }
            end
            describe '#sub_library_code' do
              subject { collections.sub_library_code }
              it { should eq 'BOBST' }
            end
            describe '#alpha' do
              subject { collections.alpha }
              it { should eq 'L' }
            end
            describe '#display' do
              subject { collections.display }
              it { should eq 'Main Collection' }
            end
          end
        end
      end
    end
  end
end
