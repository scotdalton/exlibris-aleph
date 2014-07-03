module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Status < Base
            attr_reader :patron_id

            def initialize(patron_id)
              @patron_id = patron_id
            end

            protected
            def path
              @path ||= "#{super}/patron/#{patron_id}/patronStatus/registration"
            end
          end
        end
      end
    end
  end
end
