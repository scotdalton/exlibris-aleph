module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        class Identifier
          attr_reader :status, :sub_library

          def initialize(status, sub_library)
            unless status.is_a?(Status)
              raise ArgumentError.new("Expecting #{status} to be a Patron::Status")
            end
            unless sub_library.is_a?(SubLibrary)
              raise ArgumentError.new("Expecting #{sub_library} to be a SubLibrary")
            end
            @status = status
            @sub_library = sub_library
          end

          def ==(other_object)
            (other_object.instance_of?(self.class) &&
              status == other_object.status &&
              sub_library == other_object.sub_library)
          end
          alias_method :eql?, :==
        end
      end
    end
  end
end
