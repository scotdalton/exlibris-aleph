require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          describe Address do
            let(:root) do 
              {
                'reply_text' => 'ok',
                'reply_code' => '0000',
                'registration' => {
                  'translate_change_active_library' => 'NYU50',
                  'institution' => {
                    'inst_name' => 'NYU50',
                    'z305_bor_status_code' => '55',
                    'z305_bor_status' => 'NYU Master.s Student',
                    'z305_bor_type' => nil,
                    'z305_expiry_date' => '20141031',
                    'code' => 'NYU50'
                  }
                }
              }
            end

            subject(:status) { Status.new(root) }
            it { should be_a Status }
            describe '#root' do
              subject { status.root }
              it { should eq root }
            end
            describe '#code' do
              subject { status.code }
              it { should eq '55' }
            end
            describe '#display' do
              subject { status.display }
              it { should eq 'NYU Master.s Student' }
            end
            describe '#type' do
              subject { status.type }
              it { should be_nil }
            end
            describe '#expiration_date' do
              subject { status.expiration_date }
              it { should eq '20141031' }
            end
            describe '#institution_code' do
              subject { status.institution_code }
              it { should eq 'NYU50' }
            end
          end
        end
      end
    end
  end
end
