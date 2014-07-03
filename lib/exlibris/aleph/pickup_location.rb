module Exlibris
  module Aleph
    class PickupLocation
      attr_reader :code, :display

      def initialize(code, display)
        @code = code
        @display = display
      end
    end
  end
end
