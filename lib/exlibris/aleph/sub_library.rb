module Exlibris
  module Aleph
    class SubLibrary
      attr_reader :code, :display, :admin_library

      def initialize(code, display, admin_library)
        unless admin_library.nil? || admin_library.is_a?(AdminLibrary)
          raise ArgumentError.new("Expecting #{admin_library} to be an AdminLibrary")
        end
        @code = code
        @display = display
        @admin_library = admin_library
      end

      def ==(other_object)
        other_object.instance_of?(self.class) && code == other_object.code
      end
      alias_method :eql?, :==

      def hash
        code.hash
      end
    end
  end
end
