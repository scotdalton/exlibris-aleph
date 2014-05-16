module Exlibris
  module Aleph
    class Patron
      class Record
        class CirculationPolicy
          class Privileges
            attr_reader :hold_request, :short_loan, :ill, 
              :booking_request, :acquisition_request

            def initialize(privileges)
              @hold_request = privileges.hold_request
              @short_loan = privileges.short_loan
              @ill = privileges.ill
              @booking_request = privileges.booking_request
              @acquisition_request = privileges.acquisition_request
            end

            def hold_request?
              hold_request == 'Y'
            end

            def short_loan?
              short_loan == 'Y'
            end

            def ill?
              ill == 'Y'
            end

            def booking_request?
              booking_request == 'Y'
            end

            def acquisition_request?
              acquisition_request == 'Y'
            end
          end
        end
      end
    end
  end
end
