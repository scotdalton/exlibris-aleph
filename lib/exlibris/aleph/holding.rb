module Exlibris
  module Aleph
    class Holding
      attr_reader :record_id, :id
      def initialize(record_id, id)
        @record_id = record_id
        @id = id
      end

      def collection
        unless client.error?
          @collection ||= collections[admin_library].find do |collection|
            collection.code == collection_code &&
              collection.sub_library == sub_library
          end
        end
      end

      def metadata
        @metadata ||= Metadata.new(client.to_xml) unless client.error?
      end

      private
      def client
        @client ||= API::Client::Record::Holding.new(record_id, id)
      end

      def admin_library
        @admin_library ||= sub_library.admin_library
      end

      def sub_library
        @sub_library ||= sub_libraries.find do |sub_library|
          sub_library.code == sub_library_code
        end
      end

      def sub_libraries
        @sub_libraries ||= tables_manager.sub_libraries
      end

      def collections
        @collections ||= tables_manager.collections
      end

      def tables_manager
        @tables_manager ||= TablesManager.instance
      end

      def sub_library_code
        @sub_library_code ||= metadata.sub_location
      end

      def collection_code
        @collection_code ||= metadata.shelving_location
      end
    end
  end
end
