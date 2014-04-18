module Exlibris
  module Aleph
    class Patron
      attr_reader :credentials

      def initialize(credentials)
        unless credentials.is_a?(Credentials)
          raise ArgumentError.new("Expecting #{credentials} to be a Credentials")
        end
        @credentials = credentials
      end
    end
  end
end
