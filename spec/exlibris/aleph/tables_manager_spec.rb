require 'spec_helper'
module Exlibris
  module Aleph
    describe TablesManager do
      subject(:tables_manager) { TablesManager.instance }
      it { should be_a TablesManager }
      describe TablesManager::TIME_TO_LIVE do
        subject { TablesManager::TIME_TO_LIVE }
        it { should eq 86400 }
      end
      describe '#equal?' do
        let(:other_instance) { TablesManager.instance }
        subject { tables_manager.equal?(other_instance) }
        it { should be_true }
      end
      describe '#expired?' do
        subject { tables_manager.expired? }
        it { should be_false }
        context 'when the table has been in use for more than a day' do
          it 'should be true' do
            expect(tables_manager.expired?).to be_false 
            Timecop.freeze(Time.now + 86401) do
              expect(subject).to be_true
            end
          end
        end
      end
      describe '#sub_libraries' do
        subject { tables_manager.sub_libraries }
        it { should be_a Table::SubLibraries }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.sub_libraries }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.sub_libraries
            end
          end
        end
      end
      describe '#collections' do
        subject { tables_manager.collections }
        it { should be_a Table::Collections }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.collections }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.collections
            end
          end
        end
      end
      describe '#patron_statuses' do
        subject { tables_manager.patron_statuses }
        it { should be_a Table::Patron::Statuses }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.patron_statuses }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.patron_statuses
            end
          end
        end
      end
      describe '#patron_circulation_policies' do
        subject { tables_manager.patron_circulation_policies }
        it { should be_a Table::Patron::CirculationPolicies }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.patron_circulation_policies }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.patron_circulation_policies
            end
          end
        end
      end
      describe '#item_circulation_policies' do
        subject { tables_manager.item_circulation_policies }
        it { should be_a Table::Item::CirculationPolicies }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.item_circulation_policies }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.item_circulation_policies
            end
          end
        end
      end
      describe '#item_display_masks' do
        subject { tables_manager.item_display_masks }
        it { should be_a Table::Item::DisplayMasks }
        context 'when the tables manager is not expired' do
          it { should be tables_manager.item_display_masks }
        end
        context 'when the tables manager is expired' do
          it 'should not be the same object' do
            subject
            Timecop.freeze(Time.now + 86401) do
              expect(subject).not_to be tables_manager.item_display_masks
            end
          end
        end
      end
    end
  end
end
