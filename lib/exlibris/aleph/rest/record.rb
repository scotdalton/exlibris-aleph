module Exlibris
  module Aleph
    module Rest
      # ==Overview
      # Provides access to the Aleph Record REST API.
      class Record < Base
        attr_accessor :bib_library, :record_id

        def initialize(*args)
          super
        end

        # Returns an XML string representation of a bib.  
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        def bib
          self.class.format :html
          self.response = self.class.get("#{record_url}?view=full")
          self.class.format :xml
          raise_error_if "Error getting bib from Aleph REST APIs."
          response.to_s
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

        # Returns an array of holdings. Each holding is represented as an HTTParty Hash.
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        def holdings
          self.response = self.class.get("#{record_url}/holdings?view=full")
          raise_error_if("Error getting holdings from Aleph REST APIs.") {
            (response.parsed_response["get_hol_list"].nil? or response.parsed_response["get_hol_list"]["holdings"].nil?)
          }
          [response.parsed_response["get_hol_list"]["holdings"]["holding"]].flatten
        end

        def record_url
          @record_url ||= "#{rest_url}/record/#{bib_library}#{record_id}"
        end
        private :record_url
      end
    end
  end
end