module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record 
            class Item < Base
              attr_reader :patron_id, :record_id, :id

              def initialize(patron_id, record_id, id)
                @patron_id = patron_id
                @record_id = record_id
                @id = id
              end

              protected
              def path
                @path ||= "#{super}/patron/#{patron_id}/record/#{record_id}/items/#{id}"
              end
            end
          end
        end
      end
    end
  end
end
