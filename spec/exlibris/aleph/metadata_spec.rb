require 'spec_helper'
module Exlibris
  module Aleph
    describe Metadata do
      let(:marc_xml) { %Q{
        <record>
          <info type="Items" href="http://aleph.library.nyu.edu:1891/rest-dlf/record/NYU01001951476/items"/>
          <info type="Holdings" href="http://aleph.library.nyu.edu:1891/rest-dlf/record/NYU01001951476/holdings"/>
          <info type="Filters" href="http://aleph.library.nyu.edu:1891/rest-dlf/record/NYU01001951476/filters"/>
          <leader>00000nas 2200241 a 4500</leader>
          <controlfield tag="001">001951476</controlfield>
          <controlfield tag="003">NNU</controlfield>
          <controlfield tag="005">20131122143305.0</controlfield>
          <controlfield tag="008">910904c19919999nyuqr p 0 0eng d</controlfield>
          <datafield tag="035" ind1=" " ind2=" ">
            <subfield code="a">(CStRLIN)NYUG91-S1859</subfield>
          </datafield>
          <datafield tag="035" ind1=" " ind2=" ">
            <subfield code="a">GLIS008967192</subfield>
          </datafield>
          <datafield tag="035" ind1="9" ind2=" ">
            <subfield code="a">NYUb10896719</subfield>
          </datafield>
          <datafield tag="040" ind1=" " ind2=" ">
            <subfield code="a">NNU</subfield>
            <subfield code="c">NNU</subfield>
          </datafield>
          <datafield tag="090" ind1=" " ind2=" ">
            <subfield code="i">09/04/91 CT</subfield>
          </datafield>
          <datafield tag="245" ind1="0" ind2="0">
            <subfield code="a">Visionaire.</subfield>
          </datafield>
          <datafield tag="260" ind1=" " ind2=" ">
            <subfield code="a">[New York] :</subfield>
            <subfield code="b">Visionaire Publishing,</subfield>
            <subfield code="c">c1991-</subfield>
          </datafield>
          <datafield tag="300" ind1=" " ind2=" ">
            <subfield code="a">v. :</subfield>
            <subfield code="b">ill. (some col.) ;</subfield>
            <subfield code="c">29 cm.</subfield>
          </datafield>
          <datafield tag="310" ind1=" " ind2=" ">
            <subfield code="a">Quarterly</subfield>
          </datafield>
          <datafield tag="362" ind1="0" ind2=" ">
            <subfield code="a">No. 1 (Spring 1991)-</subfield>
          </datafield>
          <datafield tag="500" ind1=" " ind2=" ">
            <subfield code="a">Title from cover.</subfield>
          </datafield>
          <datafield tag="650" ind1=" " ind2="0">
            <subfield code="a">Fashion</subfield>
            <subfield code="v">Periodicals.</subfield>
          </datafield>
          <datafield tag="650" ind1=" " ind2="0">
            <subfield code="a">Art, Modern</subfield>
            <subfield code="y">20th century</subfield>
            <subfield code="v">Periodicals.</subfield>
          </datafield>
          <datafield tag="866" ind1="4" ind2="1">
            <subfield code="l">New School Gimbel</subfield>
            <subfield code="d">Special Collections Periodicals</subfield>
            <subfield code="e">1306</subfield>
            <subfield code="i">
              Latest issues held in Periodicals; bound volumes held Offsite.
            </subfield>
          </datafield>
          <datafield tag="866" ind1="4" ind2="1">
            <subfield code="l">New School Gimbel Offsite</subfield>
            <subfield code="d">Special Collections Periodicals</subfield>
            <subfield code="e">1306</subfield>
            <subfield code="j">1-</subfield>
            <subfield code="k">1991-</subfield>
          </datafield>
          <datafield tag="998" ind1=" " ind2=" ">
            <subfield code="a">09/04/91</subfield>
            <subfield code="t">c</subfield>
            <subfield code="s">9114</subfield>
            <subfield code="n">NNU</subfield>
            <subfield code="d">09/04/91</subfield>
            <subfield code="c">JJR</subfield>
            <subfield code="b">MJD</subfield>
            <subfield code="i">910904</subfield>
            <subfield code="l">NYUG</subfield>
          </datafield>
          <datafield tag="966" ind1="4" ind2="1">
            <subfield code="l">
              New School University Center Special Collections Periodicals
            </subfield>
            <subfield code="e">1306</subfield>
            <subfield code="i">
              Latest issues held in Periodicals; bound volumes held Offsite.
            </subfield>
          </datafield>
          <datafield tag="966" ind1="4" ind2="1">
            <subfield code="l">
              New School University Center Special Collections Periodicals
            </subfield>
            <subfield code="e">1306</subfield>
            <subfield code="j">1-</subfield>
            <subfield code="k">1991-</subfield>
          </datafield>
        </record>
      }}
      subject(:metadata) { Metadata.new(marc_xml) }
      describe '#marc_xml' do
        subject { metadata.marc_xml }
        it { should eq marc_xml.strip }
      end
      describe '#marc_record' do
        subject { metadata.marc_record }
        it { should be_a MARC::Record }
      end
    end
  end
end
