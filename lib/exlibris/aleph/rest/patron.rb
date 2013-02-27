module Exlibris
  module Aleph
    module Rest
      # ==Overview
      # Provides access to the Aleph Patron REST API.
      class Patron < Base
        attr_accessor :patron_id

        # Place a hold on the specificed item.
        # Raises an error if there was a problem placing the hold.
        # Returns a HTTParty::Response.
        def place_hold(adm_library, bib_library, bib_id, item_id, params)
          options = { :body => "post_xml=#{place_hold_xml(params)}"}
          self.response = self.class.put("#{patron_url}/record/#{bib_library}#{bib_id}/items/#{item_id}/hold", options)
          raise_error_if "Error placing hold through Aleph REST APIs. #{error}"
          return response
        end

        # Call the patronInformation/address Aleph Patron REST API
        # Returns a HTTParty::Response.
        def address()
          self.response = self.class.get("#{patron_url}/patronInformation/address")
          raise_error_if "Error getting patron's address through Aleph REST APIs."
          return response
        end

        # Call the circulationActions/loans Aleph Patron REST API
        # Returns a HTTParty::Response.
        def loans()
          self.response = self.class.get("#{patron_url}/circulationActions/loans?view=full")
          raise_error_if "Error getting loans through Aleph REST APIs."
          return response
        end

        # Renew the specified item.
        # Will renew all if item not specified.
        # Returns a HTTParty::Response.
        def renew_loans(item_id="")
          self.response = self.class.post("#{patron_url}/circulationActions/loans/#{item_id}")
          raise_error_if "Error renewing loan(s) through Aleph REST APIs."
          return response
        end

        # Returns the note associated with the request.
        def note
          return (not response.first.last.kind_of?(Hash) or response.first.last["create_hold"].nil?) ? "" : ": #{response.first.last["create_hold"]["note"]["__content__"]}" if response.instance_of?(Hash)
        end

        # Returns the error associated with the request.
        # Returns nil if no error.
        def error
          return nil if reply_code == "0000"
          return "#{reply_text}#{note}"
        end

        def patron_url
          @patron_url ||= "#{rest_url}/patron/#{patron_id}"
        end
        private :patron_url

        def place_hold_xml(params)
          pickup_location = params[:pickup_location]
          last_interest_date = params.fetch(:last_interest_date, "")
          start_interest_date = params.fetch(:start_interest_date, "")
          sub_author = params.fetch(:sub_author, "")
          sub_title = params.fetch(:sub_title, "")
          pages = params.fetch(:pages, "")
          note_1 = params.fetch(:note_1, "")
          note_2 = params.fetch(:note_2, "")
          rush = params.fetch(:rush, "N")
          build_xml { |xml|
            xml.send(:"hold-request-parameters") {
              xml.send :"pickup-location", pickup_location
              xml.send :"last-interest-date", last_interest_date
              xml.send :"start-interest-date", start_interest_date
              xml.send :"sub-author", sub_author
              xml.send :"sub-title", sub_title
              xml.send :"pages", pages
              xml.send :"note-1", note_1
              xml.send :"note-2", note_2
              xml.send :"rush", rush
            }
          }
        end
      end
    end
  end
end