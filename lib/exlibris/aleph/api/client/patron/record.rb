module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record < Base
            attr_reader :patron_id, :id

            def initialize(patron_id, id)
              @patron_id = patron_id
              @id = id
            end

            protected
            def path
              @path ||= "#{super}/patron/#{patron_id}/record/#{id}"
            end
          end
        end
      end
    end
  end
end
