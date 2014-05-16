module Exlibris
  module Aleph
    class Patron
      attr_reader :id, :admin_library, :address

      def initialize(id)
        @id = id
        @admin_library = AdminLibrary.new(reader.admin_library_code)
        @address = Address.new(id)
      end

      def record(record_id)
        Record.new(id, record_id)
      end

      private
      def client
        @client ||= API::Client::Patron.new(id)
      end

      def root
        @root ||= client.root
      end

      def reader
        @reader ||= API::Reader::Patron.new(root)
      end
    end
  end
end
