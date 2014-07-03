module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          class CirculationPolicy
            class Privileges
              attr_reader :hold_request, :short_loan, :photocopy_request,
                :booking_request

              def initialize(privileges)
                @hold_request = privileges.hold_request
                @short_loan = privileges.short_loan
                @photocopy_request = privileges.photocopy_request
                @booking_request = privileges.booking_request
              end

              def hold_request?
                hold_request == 'Y'
              end

              def short_loan?
                short_loan == 'Y'
              end

              def photocopy_request?
                photocopy_request == 'Y'
              end

              def booking_request?
                booking_request == 'Y'
              end
            end
          end
        end
      end
    end
  end
end
