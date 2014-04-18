module Exlibris
  module Aleph
    module Rest
      require 'faraday'
      require 'multi_xml'
      class Base
        VALID_VIEWS = ['full', 'brief']

        attr_reader :query

        def initialize(query={})
          unless query.is_a?(Hash)
            raise ArgumentError.new("Expecting #{query} to be a Hash")
          end
          view = query[:view]
          unless view.nil? || VALID_VIEWS.include?(view)
            raise ArgumentError.new("Expecting #{view} to be one of #{VALID_VIEWS.join(', ')}")
          end
          @query ||= query.map { |key, value| "#{key}=#{value}"}.join('&')
        end

        def error?
          reply_code != '0000'
        end

        def reply_code
          @reply_code ||= meat['reply_code']
        end

        def reply_text
          @reply_text ||= meat['reply_text']
        end

        def to_h
          @hash ||= MultiXml.parse(to_xml)
        end

        def to_xml
          @xml ||= body.to_s
        end

        protected
        def path
          @path ||= '/rest-dlf'
        end

        private
        def meat
          @meat ||= to_h[root]
        end

        def root
          @root ||= to_h.keys.first
        end

        def body
          @body ||= response.body
        end

        def response
          @response ||= connection.get("#{path}?#{query}")
        end

        def connection
          @connection ||= Faraday.new(url: rest_url)
        end
        def rest_url
          @rest_url ||= Config.rest_url
        end
      end
    end
  end
end