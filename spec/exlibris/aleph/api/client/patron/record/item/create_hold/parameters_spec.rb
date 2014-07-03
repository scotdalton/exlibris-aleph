require 'spec_helper'
module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              class CreateHold
                describe Parameters do
                  let(:pickup_location) do
                    Exlibris::Aleph::PickupLocation.new('BOBST', 'NYU Bobst')
                  end
                  let(:last_interest_date) { '20140915' }
                  let(:start_interest_date) { '20140915' }
                  let(:sub_author) { 'Sub Author' }
                  let(:sub_title) { 'Sub Title' }
                  let(:pages) { 'Pages' }
                  let(:note_1) { 'Note 1' }
                  let(:note_2) { 'Note 2' }
                  let(:rush) { 'N' }
                  let(:input_parameters) do
                    {
                      pickup_location: pickup_location,
                      last_interest_date: last_interest_date,
                      start_interest_date: start_interest_date,
                      sub_author: sub_author,
                      sub_title: sub_title,
                      pages: pages,
                      note_1: note_1,
                      note_2: note_2,
                      rush: rush
                    }
                  end
                  subject(:parameters) { Parameters.new(input_parameters) }
                  it { should be_a Parameters }
                  describe '#pickup_location' do
                    subject { parameters.pickup_location }
                    it { should eq pickup_location }
                  end
                  describe '#last_interest_date' do
                    subject { parameters.last_interest_date }
                    it { should eq last_interest_date }
                  end
                  describe '#start_interest_date' do
                    subject { parameters.start_interest_date }
                    it { should eq start_interest_date }
                  end
                  describe '#sub_author' do
                    subject { parameters.sub_author }
                    it { should eq sub_author }
                  end
                  describe '#sub_title' do
                    subject { parameters.sub_title }
                    it { should eq sub_title }
                  end
                  describe '#pages' do
                    subject { parameters.pages }
                    it { should eq pages }
                  end
                  describe '#note_1' do
                    subject { parameters.note_1 }
                    it { should eq note_1 }
                  end
                  describe '#note_2' do
                    subject { parameters.note_2 }
                    it { should eq note_2 }
                  end
                  describe '#rush' do
                    subject { parameters.rush }
                    it { should eq rush }
                  end
                  context 'when the input parameters is not a Hash' do
                    let(:input_parameters) { 'invalid' }
                    it 'should raise an ArgumentError' do
                      expect { subject }.to raise_error ArgumentError
                    end
                  end
                  context 'when the input parameters is a Hash' do
                    context 'but the pickup location is not a PickupLocation' do
                      let(:pickup_location) { 'invalid' }
                      it 'should raise an ArgumentError' do
                        expect { subject }.to raise_error ArgumentError
                      end
                    end
                    context 'and the pickup location is nil' do
                      let(:pickup_location) { nil }
                      it 'should not raise an ArgumentError' do
                        expect { subject }.not_to raise_error
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
  end
end
