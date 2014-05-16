module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          class CirculationPolicy
            attr_reader :privileges, :pickup_locations

            def initialize(privileges, *pickup_locations)
              unless privileges.is_a?(Privileges)
                raise ArgumentError.new("Expecting #{privileges} to be a Privileges")
              end
              @privileges = privileges
              @pickup_locations = pickup_locations
            end
          end
        end
      end
    end
  end
end
