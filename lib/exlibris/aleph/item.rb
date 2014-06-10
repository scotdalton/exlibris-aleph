module Exlibris
  module Aleph
    class Item
      ON_SHELF_VALUES = ['On Shelf']

      attr_reader :record_id, :id

      def initialize(record_id, id)
        @record_id = record_id
        @id = id
      end

      def collection
        unless client.error?
          @collection ||=
            Collection.new(collection_code, collection_display, sub_library)
        end
      end

      def call_number
        unless client.error?
          @call_number ||=
            CallNumber.new(reader.classification, reader.description)
        end
      end

      def circulation_status
        unless client.error?
          @circulation_status ||=
            CirculationStatus.new(reader.circulation_status_value)
        end
      end

      def status
        unless client.error?
          @status ||= Status.new(status_code, status_display)
        end
      end

      def processing_status
        unless client.error?
          @processing_status ||=
            ProcessingStatus.new(processing_status_code, processing_status_display)
        end
      end

      def on_shelf?
        !client.error? && ON_SHELF_VALUES.include?(circulation_status.value)
      end

      def circulation_policy
        unless client.error?
          @circulation_policy ||=
            circulation_policies.find_by_identifier(circulation_policy_identifier)
        end
      end

      private
      def client
        @client ||= API::Client::Record::Item.new(record_id, id)
      end

      def root
        @root ||= client.root
      end

      def reader
        @reader ||= API::Reader::Record::Item.new(root)
      end

      def admin_library
        @admin_library ||= AdminLibrary.new(reader.admin_library_code)
      end

      def sub_library
        @sub_library ||=
          SubLibrary.new(sub_library_code, sub_library_display, admin_library)
      end

      def sub_library_code
        @sub_library_code ||= reader.sub_library_code
      end

      def sub_library_display
        @sub_library_display ||= reader.sub_library_display
      end

      def collection_code
        @collection_code ||= reader.collection_code
      end

      def collection_display
        @collection_display ||= reader.collection_display
      end

      def status_code
        @status_code ||= (reader.status_code || '##')
      end

      def status_display
        @status_display ||= reader.status_display
      end

      def processing_status_code
        @processing_status_code ||= (reader.processing_status_code || '##')
      end

      def processing_status_display
        @processing_status_display ||= reader.processing_status_display
      end

      def circulation_policies
        tables_manager.item_circulation_policies
      end

      def tables_manager
        @tables_manager ||= TablesManager.instance
      end

      def circulation_policy_identifier
        @circulation_policy_identifier ||=
          CirculationPolicy::Identifier.new(status, processing_status, sub_library)
      end
    end
  end
end
