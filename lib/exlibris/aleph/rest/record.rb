module Exlibris
  module Aleph
    module Rest
      # ==Overview
      # Provides access to the Aleph Record REST API.
      class Record < Base
        attr_accessor :bib_library, :record_id

        def initialize(*args)
          super
          # Format :xml parses response as a hash.
          # Eventually I'd like this to be the default since it raises exceptions for invalid XML.
          # self.class.format :xml
          # Format :html does no parsing, just passes back raw XML for parsing by client
          self.class.format :html
        end

        # Returns an XML string representation of a bib.  
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        # Returns a HTTParty::Response.
        def bib
          self.response = self.class.get("#{record_url}?view=full")
          raise_error_if "Error getting bib from Aleph REST APIs."
          return response
        end

        # Returns an array of items. Each item is represented as an HTTParty hash. 
        # Every method call refreshes the data from the underlying API.
        # Raises an exception if the response is not valid XML or there are errors.
        # Returns a HTTParty::Response.
        def items
          self.class.format :xml
          # Since we're parsing xml, this will raise an error
          # if the response isn't xml.
          self.response = self.class.get("#{record_url}/items?view=full")
          self.class.format :html
          raise_error_if("Error getting items from Aleph REST APIs.") {
            (response["get_item_list"].nil? or response["get_item_list"]["items"].nil?)
          }
          item_list = response["get_item_list"]["items"]["item"]
          items = item_list.is_a?(Array) ? item_list : [item_list]
        end

        # Returns an XML string representation of holdings 
        # Every method call refreshes the data from the underlying API.
        # Raises and exception if there are errors.
        # Returns a HTTParty::Response.
        def holdings
          self.response = self.class.get("#{record_url}/holdings?view=full")
          raise_error_if "Error getting holdings from Aleph REST APIs. #{error}"
          return response
        end

        def record_url
          @record_url ||= "#{rest_url}/record/#{bib_library}#{record_id}"
        end
        private :record_url
      end
    end
  end
end