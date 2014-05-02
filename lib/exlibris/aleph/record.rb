module Exlibris
  module Aleph
    class Record
      attr_reader :id, :admin_library
      def initialize(id, admin_library)
        @id = id
        @admin_library = admin_library
      end

      def metadata
        @metadata ||= Metadata.new(rest_record.to_xml)
      end

      def holdings
        @holdings ||= Holdings.new(record_id).to_a
      end

      def items
        @items ||= Items.new(record_id).to_a
      end

      private
      def rest_record
        @rest_record ||= Rest::Record.new(record_id, { view: 'full' })
      end

      def record_id
        @record_id ||= admin_library.code + id
      end
    end
  end
end