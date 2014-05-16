module Exlibris
  module Aleph
    class Items
      attr_reader :record_id

      def initialize(record_id)
        @record_id = record_id
      end

      def to_a
        ids.map { |id| Item.new(record_id, id) }
      end

      private
      def client
        @client ||= API::Client::Record::Items.new(record_id)
      end

      def root
        @root ||= client.to_h['get_item_list']
      end

      def items_root
        @items_root ||= root['items']
      end

      def items
        @items ||= items_root['item']
      end

      def ids
        items.map do |item|
          item['href'].split('/').pop
        end
      end
    end
  end
end
