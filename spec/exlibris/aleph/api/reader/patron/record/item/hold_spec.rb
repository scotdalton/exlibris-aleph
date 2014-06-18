require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          class Record
            class Item
              describe Hold do
                let(:pickup_locations) { nil }
                let(:root) do
                  {
                    'reply_text' => 'ok',
                    'reply_code' => '0000',
                    'hold' => {
                      'note' => [
                        nil, {
                          '__content__' => 'Item status: Regular loan<br /> Call number: HN90.I56 K888 2003<br />',
                          'type' => 'info'
                        }
                      ],
                      'last_interest_date' => {
                        '__content__' => '20140915',
                        'usage' => 'Optional'
                      },
                      'start_interest_date' => {
                        'usage' => 'Optional'
                      },
                      'sub_author' => {
                        'usage' => 'Optional',
                        'max_len' => '50'
                      },
                      'sub_title' => {
                        'usage' => 'Optional',
                        'max_len' => '100'
                      },
                      'pages' => {
                        'usage' => 'Optional',
                        'max_len' => '30'
                      },
                      'note_1' => {
                        'usage' => 'Optional',
                        'max_len' => '50'
                      },
                      'note_2' => {
                        'usage' => 'Optional',
                        'max_len' => '50'
                      },
                      'rush' => {
                        'usage' => 'Optional'
                      },
                      'allowed' => 'Y'
                    }
                  }
                end
                before { root['hold']['pickup_locations'] = pickup_locations }
                subject(:hold) { Hold.new(root) }
                it { should be_a Hold }
                describe '#root' do
                  subject { hold.root }
                  it { should eq root }
                end
                describe '#allowed' do
                  subject { hold.allowed }
                  it { should eq 'Y' }
                end
                describe '#pickup_locations' do
                  subject { hold.pickup_locations }
                  it { should be_an Array }
                  context 'when pickup locations is nil' do
                    let(:pickup_locations) { nil }
                    it { should be_an Array }
                    it { should be_empty }
                  end
                  context 'when there are no pickup locations' do
                    let(:pickup_locations) { {'usage' => 'Mandatory'} }
                    it { should be_an Array }
                    it { should be_empty }
                  end
                  context 'when there is only one pickup location' do
                    let(:pickup_locations) do
                      {
                        'pickup_location' => {
                          '__content__' => 'NYU Bobst',
                          'code' => 'BOBST'
                        },
                        'default' => 'Y',
                        'usage' => 'Mandatory'
                      }
                    end
                    it { should be_an Array }
                    it { should_not be_empty }
                  end
                  context 'when there are multiple pickup locations' do
                    let(:pickup_locations) do
                      {
                        'pickup_location' => [
                          {
                            '__content__' => 'NYU Bobst',
                            'code' => 'BOBST'
                          }, {
                            '__content__' => 'NYU Courant',
                            'code' => 'NCOUR'
                          }, {
                            '__content__' => 'NYU Institute of Fine Arts',
                            'code' => 'NIFA'
                          }, {
                            '__content__' => 'NYU Inst Study Ancient World',
                            'code' => 'NISAW'
                          }, {
                            '__content__' => 'NYU Jack Brause',
                            'code' => 'NREI'
                          }, {
                            '__content__' => 'NYU Poly',
                            'code' => 'NPOLY'
                          }, {
                            '__content__' => 'NYU Abu Dhabi Library (UAE)',
                            'code' => 'NYUAB'
                          }, {
                            '__content__' => 'NYUAD Ctr for Sci & Eng (UAE)',
                            'code' => 'NYUSE'
                          }, {
                            '__content__' => 'NYUAD Sama Fac Offices (UAE)',
                            'code' => 'NYUSS'
                          }, {
                            '__content__' => 'NYU Shanghai Library (China)',
                            'code' => 'NYUSX'
                          }
                        ],
                        'default' => 'Y',
                        'usage' => 'Mandatory'
                      }
                    end
                    it { should be_an Array }
                    it { should_not be_empty }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
