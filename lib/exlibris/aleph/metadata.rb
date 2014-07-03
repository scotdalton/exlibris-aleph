module Exlibris
  module Aleph
    require 'marc'
    class Metadata
      attr_reader :marc_xml

      def initialize(marc_xml)
        @marc_xml = marc_xml.strip
      end

      def marc_record
        @marc_record ||= marc_xml_reader.first
      end

      private
      def string_io
        StringIO.new(marc_xml)
      end

      def marc_xml_reader
        MARC::XMLReader.new(string_io)
      end
    end
  end
end
