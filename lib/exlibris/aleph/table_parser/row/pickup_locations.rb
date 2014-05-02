module Exlibris
  module Aleph
    module TableParser
      module Row
        class PickupLocations < Base
          attr_ordered_keys :sub_library_code, :item_status_code,
            :item_processing_status_code, :patron_status_code,
            :availability_flag

          def pickup_locations
            @pickup_locations ||= data.slice(5, data.size - 5).map(&:strip)
          end
        end
      end
    end
  end
end
