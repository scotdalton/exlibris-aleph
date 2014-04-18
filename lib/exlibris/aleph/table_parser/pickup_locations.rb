module Exlibris
  module Aleph
    module TableParser
      class PickupLocations < Base
        FILENAME = 'tab37'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end
      end
    end
  end
end
