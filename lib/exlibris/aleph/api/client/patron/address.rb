module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Address < Base
            attr_reader :patron_id

            def initialize(patron_id)
              @patron_id = patron_id
            end

            protected
            def path
              @path ||= "#{super}/patron/#{patron_id}/patronInformation/address"
            end
          end
        end
      end
    end
  end
end
