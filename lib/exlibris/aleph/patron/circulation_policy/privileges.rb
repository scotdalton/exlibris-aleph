module Exlibris
  module Aleph
    class Patron
      class CirculationPolicy
        class Privileges

          attr_reader :borrow, :photocopy, :request, :request_multiple,
            :request_on_shelf, :renew, :book, :rush_cataloging

          def initialize(row)
            @borrow = row.borrow
            @photocopy = row.photocopy
            @request = row.request
            @request_multiple = row.request_multiple
            @request_on_shelf = row.request_on_shelf
            @renew = row.renew
            @book = row.book
            @rush_cataloging = row.rush_cataloging
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
