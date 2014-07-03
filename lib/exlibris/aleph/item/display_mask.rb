module Exlibris
  module Aleph
    class Item
      class DisplayMask
        attr_reader :value, :mask

        def initialize(value, mask)
          @value = value
          @mask = mask
        end

        def ==(other_object)
          other_object.instance_of?(self.class) && value == other_object.value
        end
        alias_method :eql?, :==
      end
    end
  end
end
