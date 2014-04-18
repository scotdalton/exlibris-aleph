module Exlibris
  module Aleph
    module Item
      class CirculationType
        class Identifier
          attr_reader :status, :processing_status, :sub_library

          def initialize(status, processing_status, sub_library)
            unless status.is_a?(Status)
              raise ArgumentError.new("Expecting #{status} to be a Item::Status")
            end
            unless processing_status.is_a?(ProcessingStatus)
              raise ArgumentError.new("Expecting #{processing_status} to be a Item::ProcessingStatus")
            end
            unless sub_library.is_a?(SubLibrary)
              raise ArgumentError.new("Expecting #{sub_library} to be a SubLibrary")
            end
            @status = status
            @processing_status = processing_status
            @sub_library = sub_library
          end

          def ==(other_object)
            (other_object.instance_of?(self.class) &&
              status == other_object.status &&
              processing_status == other_object.processing_status && 
              sub_library == other_object.sub_library)
          end
          alias_method :eql?, :==
        end
      end
    end
  end
end
