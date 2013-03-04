module Exlibris
  module Aleph
    module Rest
      require 'marc'
      # ==Overview
      # Provides access to the Aleph Record REST API.
      class Record < Base
        attr_accessor :bib_library, :record_id

        def initialize(*args)
          super
        end

        # Returns a MARC::Record that contains the bib data
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        def bib
          self.response = self.class.get("#{record_url}?view=full")
          raise_error_if("Error getting bib from Aleph REST APIs.") {
            (response.parsed_response["get_record"].nil? or response.parsed_response["get_record"]["record"].nil?)
          }
          MARC::XMLReader.new(StringIO.new(xml(xml: response.body).at_xpath("get-record/record").to_xml(xml_options).strip)).first
        end

        # Returns an array of items. Each item is represented as an HTTParty Hash.
        # Every method call refreshes the data from the underlying API.
        # Raises an exception if the response is not valid XML or there are errors.
        def items
          # Since we're parsing xml, this will raise an error
          # if the response isn't xml.
          self.response = self.class.get("#{record_url}/items?view=full")
          raise_error_if("Error getting items from Aleph REST APIs.") {
            (response.parsed_response["get_item_list"].nil? or response.parsed_response["get_item_list"]["items"].nil?)
          }
          [response.parsed_response["get_item_list"]["items"]["item"]].flatten
        end

        # Returns an array of holdings. Each holding is represented as a MARC::Record.
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        def holdings
          self.response = self.class.get("#{record_url}/holdings?view=full")
          raise_error_if("Error getting holdings from Aleph REST APIs.") {
            (response.parsed_response["get_hol_list"].nil? or response.parsed_response["get_hol_list"]["holdings"].nil?)
          }
          xml(xml: response.body).xpath("get-hol-list/holdings/holding").collect{ |holding|
            # Change the tag name to record so that the MARC::XMLReader can parse it.
            holding.name = "record"
            MARC::XMLReader.new(StringIO.new(holding.to_xml(xml_options).strip)).first
          }
        end

        def record_url
          @record_url ||= "#{rest_url}/record/#{bib_library}#{record_id}"
        end
        private :record_url
      end
    end
  end
end