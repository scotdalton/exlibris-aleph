module Exlibris
  module Aleph
    class Items

      extend Forwardable
      def_delegators :to_a, :each, :size

      include Enumerable

      attr_reader :record_id

      def initialize(record_id)
        @record_id = record_id
      end

      def to_a
        @array ||= ids.map { |id| Item.new(record_id, id) }
      end

      private
      def client
        @client ||= API::Client::Record::Items.new(record_id)
      end

      def root
        @root ||= client.root
      end

      def items_root
        @items_root ||= root['items']
      end

      def items
        @items ||= items_root['item'] unless items_root.nil?
      end

      def ids
        @ids ||= begin
          if items.nil?
            []
          else
            items.map do |item|
              href = (items.size > 1) ? item['href'] : item[1]
              href.split('/').pop
            end
          end
        end
      end
    end
  end
end
