module Exlibris
  module Aleph
    class Record
      class Metadata < Exlibris::Aleph::Metadata

        private
        def rest_record
          @rest_record ||= Rest::Record.new(rest_id, { view: 'full' })
        end

        def rest_id
          @rest_id ||= admin_library.code + id
        end
      end
    end
  end
end
