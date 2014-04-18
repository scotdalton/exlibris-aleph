module Exlibris
  module Aleph
    class Collection
      attr_reader :code, :display, :sub_library

      def initialize(code, display, sub_library)
        unless sub_library.is_a?(SubLibrary)
          raise ArgumentError.new("Expecting #{sub_library} to be an SubLibrary")
        end
        @code = code
        @display = display
        @sub_library = sub_library
      end
    end
  end
end
