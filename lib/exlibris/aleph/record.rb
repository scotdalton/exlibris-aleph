module Exlibris
  module Aleph
    class Record

      attr_reader :id

      def initialize(id)
        @id = id
      end

      def metadata
        @metadata ||= Metadata.new(client.to_xml) unless client.error?
      end

      def holdings
        @holdings ||= Holdings.new(id).to_a
      end

      def items
        @items ||= Items.new(id).to_a
      end

      private
      def client
        @client ||= API::Client::Record.new(id, {view: 'full'})
      end
    end
  end
end