module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        attr_reader :identifier, :privileges

        def initialize(identifier, privileges)
          unless identifier.is_a?(Identifier)
            raise ArgumentError.new("Expecting #{identifier} to be a Patron::CirculationPolicy::Identifier")
          end
          unless privileges.is_a?(Privileges)
            raise ArgumentError.new("Expecting #{privileges} to be a Patron::CirculationPolicy::Privileges")
          end
          @identifier = identifier
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
