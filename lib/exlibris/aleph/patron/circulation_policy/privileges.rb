module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        class Privileges

          attr_reader :borrow, :photocopy, :request, :request_multiple,
            :request_on_shelf, :renew, :book, :rush_cataloging

          def initialize(privileges)
            @borrow = privileges.borrow
            @photocopy = privileges.photocopy
            @request = privileges.request
            @request_multiple = privileges.request_multiple
            @request_on_shelf = privileges.request_on_shelf
            @renew = privileges.renew
            @book = privileges.book
            @rush_cataloging = privileges.rush_cataloging
          end

          def can_borrow?
            borrow == 'Y'
          end

          def can_photocopy?
            photocopy == 'Y'
          end

          def can_request?
            request == 'Y'
          end

          def can_request_multiple?
            request_multiple == 'Y'
          end

          def can_request_on_shelf?
            request_on_shelf == 'Y'
          end

          def can_renew?
            renew == 'Y'
          end

          def can_book?
            book == 'Y'
          end

          def can_rush_cataloging?
            rush_cataloging == 'Y'
          end
        end
      end
    end
  end
end
