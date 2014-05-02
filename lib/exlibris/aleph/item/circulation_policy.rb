module Exlibris
  module Aleph
    class Item
      class CirculationPolicy
        attr_reader :identifier, :display, :privileges

        def initialize(identifier, display, privileges)
          unless identifier.is_a?(Identifier)
            raise ArgumentError.new("Expecting #{identifier} to be a Item::CirculationPolicy::Identifier")
          end
          unless display.is_a?(Display)
            raise ArgumentError.new("Expecting #{identifier} to be a Item::CirculationPolicy::Display")
          end
          unless privileges.is_a?(Privileges)
            raise ArgumentError.new("Expecting #{privileges} to be a Item::CirculationPolicy::Privileges")
          end
          @identifier = identifier
          @display = display
          @privileges = privileges
        end

        def ==(other_object)
          (other_object.instance_of?(self.class) &&
            identifier == other_object.identifier)
        end
        alias_method :eql?, :==
      end
    end
  end
end
