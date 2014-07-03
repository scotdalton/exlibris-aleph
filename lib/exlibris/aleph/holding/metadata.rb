module Exlibris
  module Aleph
    class Holding
      require 'marc'
      class Metadata < Exlibris::Aleph::Metadata
        attr_reader :marc_xml

        def initialize(marc_xml)
          marc_xml.gsub!('<holding>', '<record>')
          marc_xml.gsub!('</holding>', '</record>')
          @marc_xml = marc_xml.strip
        end

        def sub_location
          @sub_location ||= location['b'] unless location.nil?
        end

        def shelving_location
          @shelving_location ||= location['c'] unless location.nil?
        end

        def location
          @location ||= marc_record['852'] unless marc_record.nil?
        end
      end
    end
  end
end
