module Exlibris
  module Aleph
    class Patron
      class Status
        attr_reader :code, :display

        def initialize(code, display)
          @code = code
          @display = display
        end
      end
    end
  end
end
