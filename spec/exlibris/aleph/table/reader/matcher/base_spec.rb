require 'spec_helper'
module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          describe Base do
            let(:regexp) { /t(est)/ }
            let(:string) { 'test' }
            subject(:base) { Base.new(regexp, string) }
            describe '#regexp' do
              subject { base.regexp }
              it { should be_a Regexp }
            end
            describe '#match_data' do
              subject { base.match_data }
              it { should be_a MatchData }
            end
            describe '#matched_data' do
              subject { base.matched_data }
              it { should be_an Array }
            end
            describe '#matches?' do
              subject { base.matches? }
              it { should be_true }
            end
          end
        end
      end
    end
  end
end
