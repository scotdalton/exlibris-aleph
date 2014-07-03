module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          class Hold
            attr_reader :patron_id, :record_id, :item_id

            def initialize(patron_id, record_id, item_id)
              @patron_id = patron_id
              @record_id = record_id
              @item_id = item_id
            end

            def pickup_locations
              @pickup_locations ||= reader.pickup_locations
            end

            def allowed?
              reader.allowed == 'Y'
            end

            private
            def client
              @client ||=
                API::Client::Patron::Record::Item::Hold.new(patron_id, record_id, item_id)
            end

            def root
              @root ||= client.root
            end

            def reader
              @reader ||= API::Reader::Patron::Record::Item::Hold.new(root)
            end
          end
        end
      end
    end
  end
end
