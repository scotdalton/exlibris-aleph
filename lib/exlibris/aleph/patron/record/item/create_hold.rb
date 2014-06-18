module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          class CreateHold
            attr_reader :patron_id, :record_id, :item_id, :parameters

            def initialize(patron_id, record_id, item_id, parameters)
              @patron_id = patron_id
              @record_id = record_id
              @item_id = item_id
              @parameters =
                API::Client::Patron::Record::Item::CreateHold::Parameters.new(parameters)
            end

            def note
              @note ||= reader.note
            end

            def error?
              reader.type == 'error'
            end

            private
            def client
              @client ||=
                API::Client::Patron::Record::Item::CreateHold.new(patron_id, record_id, item_id, parameters)
            end

            def root
              @root ||= client.root
            end

            def reader
              @reader ||= API::Reader::Patron::Record::Item::CreateHold.new(root)
            end
          end
        end
      end
    end
  end
end
