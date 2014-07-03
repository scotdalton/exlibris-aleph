module Exlibris
  module Aleph
    class Patron
      class Record
        class Item
          attr_reader :patron_id, :record_id, :id

          def initialize(patron_id, record_id, id)
            @patron_id = patron_id
            @record_id = record_id
            @id = id
          end

          def item
            @item ||= Aleph::Item.new(record_id, id).tap do |item|
              client = self.send(:client)
              root = self.send(:root)
              reader = self.send(:reader)
              item.instance_eval { instance_variable_set(:@client, client) }
              item.instance_eval { instance_variable_set(:@root, root) }
              item.instance_eval { instance_variable_set(:@reader, reader) }
            end
          end

          def circulation_policy
            @circulation_policy ||=
              CirculationPolicy.new(privileges, *pickup_locations)
          end

          def hold
            @hold ||= Hold.new(patron_id, record_id, id)
          end

          def create_hold(parameters)
            CreateHold.new(patron_id, record_id, id, parameters)
          end

          private
          def privileges
            @privileges ||= CirculationPolicy::Privileges.new(reader)
          end

          def pickup_locations
            @pickup_locations ||= reader.pickup_locations
          end

          def client
            @client ||=
              API::Client::Patron::Record::Item.new(patron_id, record_id, id)
          end

          def root
            @root ||= client.root
          end

          def reader
            @reader ||= API::Reader::Patron::Record::Item.new(root)
          end
        end
      end
    end
  end
end
