require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Reader
        class Patron
          class Record
            class Item
              describe CreateHold do
                let(:root) do
                  {
                    'reply_text' => 'ok',
                    'reply_code' => '0000',
                    'create_hold' => {
                      'note' => {
                        '__content__' => 'Action Succeeded',
                        'type' => 'info'
                      }
                    }
                  }
                end
                subject(:hold) { CreateHold.new(root) }
                it { should be_a CreateHold }
                describe '#root' do
                  subject { hold.root }
                  it { should eq root }
                end
                describe '#note' do
                  subject { hold.note }
                  it { should eq 'Action Succeeded' }
                end
                describe '#type' do
                  subject { hold.type }
                  it { should eq 'info' }
                end
                context 'when the user does not have permission to place a hold' do
                  let(:root) do
                    {
                      'reply_text' => 'Failed to create request',
                      'reply_code' => '0025',
                      'create_hold' => {
                        'note' => {
                          '__content__' => 'Item or like copy is on shelf. Cannot place hold request.',
                          'type' => 'error'
                        }
                      }
                    }
                  end
                  describe '#note' do
                    subject { hold.note }
                    it { should eq 'Item or like copy is on shelf. Cannot place hold request.' }
                  end
                  describe '#type' do
                    subject { hold.type }
                    it { should eq 'error' }
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
