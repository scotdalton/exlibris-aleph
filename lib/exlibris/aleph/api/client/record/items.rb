module Exlibris
  module Aleph
    module API
      module Client
        class Record
          class Items < Base
            attr_reader :record_id

            def initialize(record_id, query={})
              super(query)
              @record_id = record_id
            end

            protected
            def path
              @path ||= "#{super}/record/#{record_id}/items"
            end
          end
        end
      end
    end
  end
end
