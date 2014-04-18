module Exlibris
  module Aleph
    module Rest
      class Record
        class Holdings < Base
          attr_reader :record_id

          def initialize(record_id, query={})
            super(query)
            @record_id = record_id
          end

          protected
          def path
            @path ||= "#{super}/record/#{record_id}/holdings"
          end
        end
      end
    end
  end
end
