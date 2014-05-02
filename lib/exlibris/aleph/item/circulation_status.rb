module Exlibris
  module Aleph
    class Item
      class CirculationStatus
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def ==(other_object)
          other_object.instance_of?(self.class) && value == other_object.value
        end
        alias_method :eql?, :==
      end
    end
  end
end
