module Exlibris
  module Aleph
    class Holding
      attr_reader :record_id, :id
      def initialize(record_id, id)
        @record_id = record_id
        @id = id
      end

      def collection
        @collection ||= collections[admin_library].find do |collection|
          collection.code == collection_code &&
            collection.sub_library == sub_library
        end
      end

      def metadata
        @metadata ||= Metadata.new(rest_record_holding.to_xml)
      end

      private
      def rest_record_holding
        @rest_record_holding ||= Rest::Record::Holding.new(record_id, id)
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
        @sub_libraries ||= SubLibraries.instance
      end

      def collections
        @collections ||= Collections.instance
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
