module Exlibris
  module Aleph
    class Holdings
      attr_reader :record_id

      def initialize(record_id)
        @record_id = record_id
      end

      def to_a
        ids.map { |id| Holding.new(record_id, id) }
      end

      private
      def rest_record_holdings
        @rest_record_holdings ||= Rest::Record::Holdings.new(record_id)
      end

      def rest_record_holdings_hash
        @rest_record_holdings_hash ||= rest_record_holdings.to_h['get_hol_list']
      end

      def holdings_hash
        @holdings_hash ||= rest_record_holdings_hash['holdings']
      end

      def holdings
        @holdings ||= holdings_hash['holding']
      end

      def ids
        holdings.map do |holding|
          holding['href'].split('/').pop
        end
      end
    end
  end
end
