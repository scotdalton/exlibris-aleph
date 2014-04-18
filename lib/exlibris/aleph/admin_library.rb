module Exlibris
  module Aleph
    class AdminLibrary
      attr_reader :code

      def initialize(code)
        unless code.is_a?(String)
          raise ArgumentError.new("Expecting #{code} to be a String")
        end
        @code = code
      end

      def normalized_code
        @normalized_code ||= code.downcase
      end

      def ==(other_object)
        other_object.instance_of?(self.class) && code == other_object.code
      end
      alias_method :eql?, :==
    end
  end
end
