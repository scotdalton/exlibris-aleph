module Exlibris
  module Aleph
    module API
      module Client
        class Record
          class Holding < Base
            attr_reader :record_id, :id

            def initialize(record_id, id)
              @record_id = record_id
              @id = id
            end

            protected
            def path
              @path ||= "#{super}/record/#{record_id}/holdings/#{id}"
            end
          end
        end
      end
    end
  end
end
