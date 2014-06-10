module Exlibris
  module Aleph
    class Holdings

      extend Forwardable
      def_delegators :to_a, :each, :size

      include Enumerable

      attr_reader :record_id

      def initialize(record_id)
        @record_id = record_id
      end

      def to_a
        @array ||= ids.map { |id| Holding.new(record_id, id) }
      end

      private
      def client
        @client ||= API::Client::Record::Holdings.new(record_id)
      end

      def root
        @root ||= client.root
      end

      def holdings_root
        @holdings_root ||= root['holdings']
      end

      def holdings
        @holdings ||= holdings_root['holding'] unless holdings_root.nil?
      end

      def ids
        @ids ||= begin
          if holdings.nil?
            []
          else
            holdings.map do |holding|
              href = (holdings.size > 1) ? holding['href'] : holding[1]
              href.split('/').pop
            end
          end
        end
      end
    end
  end
end
