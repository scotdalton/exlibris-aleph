module Exlibris
  module Aleph
    # ==Overview
    # Provides access to the Aleph Patron REST API.
    class Patron < Rest
      attr_reader :patron_id
      
      # Creates an instance of Exlibris::Aleph::Patron for the given :patron_id
      def initialize(patron_id, uri)
        @patron_id = patron_id
        raise "Initialization error in #{self.class}. Missing patron id." if @patron_id.nil?
        super(uri)
        @uri = @uri+ "/patron/#{patron_id}"
      end

      # Place a hold on the specificed item.
      # Raises an error if there was a problem placing the hold.
      # Returns a HTTParty::Response.
      def place_hold(adm_library, bib_library, bib_id, item_id, params)
        pickup_location = params[:pickup_location]
        raise "Error in place hold.  Missing pickup location." if pickup_location.nil?
        last_interest_date = params.fetch(:last_interest_date, "")
        start_interest_date = params.fetch(:start_interest_date, "")
        sub_author = params.fetch(:sub_author, "")
        sub_title = params.fetch(:sub_title, "")
        pages = params.fetch(:pages, "")
        note_1 = params.fetch(:note_1, "")
        note_2 = params.fetch(:note_2, "")
        rush = params.fetch(:rush, "N")
        body_str = "<hold-request-parameters>"
        body_str << "<pickup-location>#{pickup_location}</pickup-location>"
        body_str << "<last-interest-date>#{last_interest_date}</last-interest-date>"
        body_str << "<start-interest-date>#{start_interest_date}</start-interest-date>"
        body_str << "<sub-author>#{sub_author}</sub-author>"
        body_str << "<sub-title>#{sub_title}</sub-title>"
        body_str << "<pages>#{pages}</pages>"
        body_str << "<note-1>#{note_1}</note-1>"
        body_str << "<note-2>#{note_2}</note-2>"
        body_str << "<rush>#{rush}</rush>"
        body_str << "</hold-request-parameters>"
        options = { :body => "post_xml=#{body_str}"}
        @response = self.class.put(@uri+ "/record/#{bib_library}#{bib_id}/items/#{item_id}/hold", options)
        raise "Error placing hold through Aleph REST APIs. #{error}" unless error.nil?
        return @response
      end

      # Call the patronInformation/address Aleph Patron REST API
      # Returns a HTTParty::Response.
      def address()
        @response = self.class.get(@uri+ "/patronInformation/address")
        return "Error getting patron's address through Aleph REST APIs. #{error}" unless error.nil?
        return @response
      end

      # Call the circulationActions/loans Aleph Patron REST API
      # Returns a HTTParty::Response.
      def loans()
        @response = self.class.get(@uri+ "/circulationActions/loans?view=full")
        raise "Error getting loans through Aleph REST APIs. #{error}" unless error.nil?
        return @response
      end

      # Renew the specified item.
      # Will renew all if item not specified.
      # Returns a HTTParty::Response.
      def renew_loans(item_id="")
        @response = self.class.post(@uri+ "/circulationActions/loans/#{item_id}")
        raise "Error renewing loan(s) through Aleph REST APIs. #{error}" unless error.nil?
        return @response
      end
      
      # Returns the note associated with the request.
      def note
        return (not @response.first.last.kind_of?(Hash) or @response.first.last["create_hold"].nil?) ? "" : ": #{@response.first.last["create_hold"]["note"]}" if @response.instance_of?(Hash)
      end
      
      # Returns the error associated with the request.
      # Returns nil if no error.
      def error
        return nil if reply_code == "0000"
        return "#{reply_text}#{note}"
      end
    end
  end
end