module Exlibris
  module Aleph
    module Item
      class ProcessingStatus
        attr_reader :code

        def initialize(code)
          @code = code
        end

        def ==(other_object)
          other_object.instance_of?(self.class) && code == other_object.code
        end
        alias_method :eql?, :==
      end
    end
  end
end
