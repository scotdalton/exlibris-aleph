module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              class Hold < Base
                attr_reader :patron_id, :record_id, :item_id, :parameters

                def initialize(patron_id, record_id, item_id)
                  @patron_id = patron_id
                  @record_id = record_id
                  @item_id = item_id
                end

                protected
                def path
                  @path ||=
                    "#{super}/patron/#{patron_id}/record/#{record_id}/items/#{item_id}/hold"
                end
              end
            end
          end
        end
      end
    end
  end
end
