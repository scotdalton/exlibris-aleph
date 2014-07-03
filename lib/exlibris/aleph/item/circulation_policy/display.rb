module Exlibris
  module Aleph
    class Item
      class CirculationPolicy
        class Display
          attr_reader :value, :mask

          def initialize(value, mask=nil)
            @value = value
            @mask = (mask || value)
          end
        end
      end
    end
  end
end
