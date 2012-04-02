module Exlibris
  module Aleph
    require 'httparty'
    # ==Overview
    # Base implementation for Aleph REST APIs.  
    # Not intended for use on its own, but should
    # instead be extended by implementing classes.
    class Rest
      include HTTParty
      format :xml
      # Create and instance of Exlibris::Aleph::Rest for the given Aleph URI.
      def initialize(uri)
        @uri = uri
        raise "Initialization error in #{self.class}. Missing URI." if @uri.nil?
      end

      # Returns the error associated with the request.
      # Returns nil if no error.
      def error
        return nil if reply_code == "0000" 
        return "#{reply_text}"
      end

      # Returns the reply code associate with the request.
      def reply_code
        return "No response." if @response.nil?
        return (not @response.first.last.kind_of?(Hash) or @response.first.last["reply_code"].nil?) ? "Unexpected response hash." : @response.first.last["reply_code"] if @response.instance_of?(Hash)
        response_match = @response.match(/\<reply-code\>(.+)\<\/reply-code\>/) if @response.instance_of?(String)
        return (response_match.nil?) ? "Unexpected response string." : response_match[1] if @response.instance_of?(String)
        return "Unexpected response type."
      end

      # Returns the reply text associate with the request.
      def reply_text
        return "No response." if @response.nil?
        return (not @response.first.last.kind_of?(Hash) or @response.first.last["reply_text"].nil?) ? "Unexpected response hash." : @response.first.last["reply_text"] if @response.instance_of?(Hash)
        response_match = @response.match(/\<reply-text\>(.+)\<\/reply-text\>/) if @response.instance_of?(String)
        return (response_match.nil?) ? "Unexpected response string." : response_match[1] if @response.instance_of?(String)
        return "Unexpected response type."
      end
    end
  end
end