require 'spec_helper'
module Exlibris
  module Aleph
    class Holding
      describe Metadata do
        let(:marc_xml) { %Q{
          <holding>
            <leader>cxH a22001092 4500</leader>
            <controlfield tag="001">002367980</controlfield>
            <controlfield tag="004">NYUb12672786</controlfield>
            <controlfield tag="005">20080531131729.0</controlfield>
            <controlfield tag="008">0510170|||||8 |001|||||0051017</controlfield>
            <datafield tag="010" ind1=" " ind2=" ">
              <subfield code="a">2002030296</subfield>
            </datafield>
            <datafield tag="020" ind1=" " ind2=" ">
              <subfield code="a">0810844915 (alk. paper)</subfield>
            </datafield>
            <datafield tag="035" ind1="9" ind2=" ">
              <subfield code="a">NYUH12672786/13890243</subfield>
            </datafield>
            <datafield tag="852" ind1="0" ind2=" ">
              <subfield code="a">NNCoo</subfield>
              <subfield code="b">CU</subfield>
              <subfield code="c">MAIN</subfield>
              <subfield code="h">HN90.I56</subfield>
              <subfield code="i">K888 2003</subfield>
              <subfield code="p">31206028778120</subfield>
              <subfield code="7">13890243</subfield>
            </datafield>
          </holding>
        }}
        subject(:metadata) { Metadata.new(marc_xml) }
        describe '#marc_xml' do
          subject { metadata.marc_xml }
          it { should eq marc_xml.strip.gsub('holding>', 'record>') }
        end
        describe '#marc_record' do
          subject { metadata.marc_record }
          it { should be_a MARC::Record }
        end
        describe '#location' do
          subject { metadata.location }
          it { should be_a MARC::DataField }
        end
        describe '#sub_location' do
          subject { metadata.sub_location }
          it { should eq 'CU' }
        end
        describe '#shelving_location' do
          subject { metadata.shelving_location }
          it { should eq 'MAIN' }
        end
      end
    end
  end
end
