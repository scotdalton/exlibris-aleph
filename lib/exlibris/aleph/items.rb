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
      def rest_record_items
        @rest_record_items ||= Rest::Record::Items.new(record_id)
      end

      def rest_record_items_hash
        @rest_record_items_hash ||= rest_record_items.to_h['get_item_list']
      end

      def items_hash
        @items_hash ||= rest_record_items_hash['items']
      end

      def items
        @items ||= items_hash['item']
      end

      def ids
        items.map do |item|
          item['href'].split('/').pop
        end
      end
    end
  end
end
