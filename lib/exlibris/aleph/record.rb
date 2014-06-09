module Exlibris
  module Aleph
    class Record

      attr_reader :id

      def initialize(id)
        @id = id
      end

      def metadata
        @metadata ||= Metadata.new(record.to_xml)
      end

      def holdings
        @holdings ||= Holdings.new(id).to_a
      end

      def items
        @items ||= Items.new(id).to_a
      end

      private
      def record
        @record ||= API::Client::Record.new(id, { view: 'full' })
      end
    end
  end
end