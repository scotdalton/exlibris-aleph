require 'spec_helper'
module Exlibris
  module Aleph
    describe Holding, vcr: {cassette_name: 'record', record: :new_episodes} do
      let(:record_id) { 'NYU01000864162' }
      let(:id) { 'NYU60002367980' }
      let(:tables_manager) { TablesManager.instance }
      subject(:holding) { Holding.new(record_id, id) }
      it { should be_a Holding }
      describe '#record_id' do
        subject { holding.record_id }
        it { should eq record_id }
      end
      describe '#id' do
        subject { holding.id }
        it { should eq id }
      end
      describe '#metadata' do
        subject { holding.metadata }
        it { should be_a Holding::Metadata }
      end
      describe '#collection' do
        let(:sub_libraries) { tables_manager.sub_libraries }
        let(:sub_library) do
          sub_libraries.find do |sub_library|
            sub_library.code == 'CU'
          end
        end
        let(:collections) { tables_manager.collections }
        let(:admin_library) { sub_library.admin_library }
        let(:collection) do
          collections[admin_library].find do |collection|
            collection.code == 'MAIN' && collection.sub_library == sub_library
          end
        end
        subject { holding.collection }
        it { should be_a Collection }
        it { should eq collection }
      end
    end
  end
end
