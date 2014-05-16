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
      def client
        @client ||= API::Client::Record::Holdings.new(record_id)
      end

      def root
        @root ||= client.to_h['get_hol_list']
      end

      def holdings_root
        @holdings_root ||= root['holdings']
      end

      def holdings
        @holdings ||= holdings_root['holding']
      end

      def ids
        holdings.map do |holding|
          holding['href'].split('/').pop
        end
      end
    end
  end
end
