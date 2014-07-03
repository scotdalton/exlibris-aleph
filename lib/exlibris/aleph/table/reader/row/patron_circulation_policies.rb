module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          class PatronCirculationPolicies < Base
            attr_ordered_keys :sub_library_code, :patron_status_code, :borrow,
              :photocopy, :override, :request_multiple, :check_loan, :request,
              :renew, :ignore_late_return, :photocopy_charge,
              :expiration_date_operator, :expiration_date_operator_type,
              :expiration_date_parameter, :cash_overspend_limit, :request_on_shelf,
              :loan_display, :reading_room_permission, :default_hold_priority,
              :book, :ignore_closing_hours_for_booking, 
              :automatically_create_aleph_record, :rush_cataloging
          end
        end
      end
    end
  end
end
