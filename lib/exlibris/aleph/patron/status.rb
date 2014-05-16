module Exlibris
  module Aleph
    class Patron
      class Status
        attr_reader :code, :display

        def initialize(code, display=nil)
          @code = code
          @display = display
        end

        def ==(other_object)
          other_object.instance_of?(self.class) && code == other_object.code
        end
        alias_method :eql?, :==
      end
    end
  end
end
