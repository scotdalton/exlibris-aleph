module Exlibris
  module Aleph
    module API
      module Client
        require 'faraday'
        require 'multi_xml'
        class Base

          DEFAULT_REQUEST_METHOD = :get

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
            @reply_code ||= root['reply_code']
          end

          def reply_text
            @reply_text ||= root['reply_text']
          end

          def root
            @root ||= to_h[root_key]
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
          def root_key
            @root_key ||= to_h.keys.first
          end

          def body
            @body ||= response.body
          end

          def response
            @response ||= send(request_method)
          end

          def get
            connection.get("#{path}?#{query}")
          end

          def request_method
            @request_method ||= DEFAULT_REQUEST_METHOD
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
end
