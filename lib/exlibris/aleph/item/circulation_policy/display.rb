module Exlibris
  module Aleph
    module Item
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
