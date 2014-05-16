module Exlibris
  module Aleph
    class Patron
      class Record
        class CirculationPolicy
          attr_reader :privileges

          def initialize(privileges)
            unless privileges.is_a?(Privileges)
              raise ArgumentError.new("Expecting #{privileges} to be a Privileges")
            end
            @privileges = privileges
          end
        end
      end
    end
  end
end
