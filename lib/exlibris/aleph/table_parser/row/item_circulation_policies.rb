module Exlibris
  module Aleph
    module TableParser
      module Row
        class ItemCirculationPolicies < Base
          attr_ordered_keys :sub_library_code, :item_status_code,
            :item_processing_status_code, :alpha, :display, :loanable,
            :renewable, :requestable, :photocopyable, :displayable,
            :specific_item, :limit_hold, :recallable, :rush_recallable,
            :reloaning_limit, :bookable, :booking_hours
        end
      end
    end
  end
end
