module Exlibris
  module Aleph
    module Rest
      require 'httparty'
      # ==Overview
      # Base implementation for Aleph REST APIs.  
      # Not intended for use on its own, but should
      # instead be extended by implementing classes.
      class Base
        include HTTParty
        include Abstract
        include Config::Attributes
        include XmlUtil
        include WriteAttributes
        self.format :xml
        self.abstract = true

        attr_accessor :rest_url, :response
        protected :response=

        # Returns the error associated with the request.
        # Returns nil if no error.
        def error
          return nil if reply_code == "0000" 
          return "#{reply_text}"
        end

        # Returns the reply code associate with the request.
        def reply_code
          return "No response." if response.nil?
          return (not response.first.last.kind_of?(Hash) or response.first.last["reply_code"].nil?) ? "Unexpected response hash." : response.first.last["reply_code"] if response.instance_of?(Hash)
          response_match = response.match(/\<reply-code\>(.+)\<\/reply-code\>/) if response.instance_of?(String)
          return (response_match.nil?) ? "Unexpected response string." : response_match[1] if response.instance_of?(String)
          return "Unexpected response type."
        end

        # Returns the reply text associate with the request.
        def reply_text
          return "No response." if response.nil?
          return (not response.first.last.kind_of?(Hash) or response.first.last["reply_text"].nil?) ? "Unexpected response hash." : response.first.last["reply_text"] if response.instance_of?(Hash)
          response_match = response.match(/\<reply-text\>(.+)\<\/reply-text\>/) if response.instance_of?(String)
          return (response_match.nil?) ? "Unexpected response string." : response_match[1] if response.instance_of?(String)
          return "Unexpected response type."
        end

        def raise_error_if *args, &block
          message = (args.shift || "Error in the Aleph REST APIs.")
          block_value = (block_given?) ? yield : false
          raise "#{message} #{error}" if error or block_value
        end
        protected :raise_error_if
      end
    end
  end
end