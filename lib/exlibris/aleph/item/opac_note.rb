module Exlibris
  module Aleph
    class Item
      class OpacNote
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def to_s
          value
        end
      end
    end
  end
end
