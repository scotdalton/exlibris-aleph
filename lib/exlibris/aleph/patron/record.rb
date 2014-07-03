module Exlibris
  module Aleph
    class Patron
      class Record
        attr_reader :patron_id, :id

        def initialize(patron_id, id)
          @patron_id = patron_id
          @id = id
        end

        def circulation_policy
          @circulation_policy ||= CirculationPolicy.new(privileges)
        end

        def item(item_id)
          Item.new(patron_id, id, item_id)
        end

        private
        def privileges
          @privileges ||= CirculationPolicy::Privileges.new(reader)
        end

        def client
          @client ||= API::Client::Patron::Record.new(patron_id, id)
        end

        def root
          @root ||= client.root
        end

        def reader
          @reader ||= API::Reader::Patron::Record.new(root)
        end
      end
    end
  end
end
