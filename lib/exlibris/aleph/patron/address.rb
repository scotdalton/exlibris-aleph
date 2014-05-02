module Exlibris
  module Aleph
    class Patron
      class Address
        attr_reader :patron_id

        def initialize(patron_id)
          @patron_id = patron_id
        end

        private
        def rest_patron_address
          @rest_patron_address ||=
            Rest::Patron::Address.new(patron_id)
        end
      end
    end
  end
end
