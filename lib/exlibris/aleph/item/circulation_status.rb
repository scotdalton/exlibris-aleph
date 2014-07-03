module Exlibris
  module Aleph
    class Item
      class CirculationStatus
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def to_s
          value
        end

        def due_date
          @due_date ||= due_date_match[0] unless due_date_match.nil?
        end

        def ==(other_object)
          other_object.instance_of?(self.class) && value == other_object.value
        end
        alias_method :eql?, :==

        private
        def due_date_match
          @due_date_match ||= value.match(/\d{2}\/\d{2}\/\d{2}/)
        end
      end
    end
  end
end
