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
        @collection ||=
          Collection.new(collection_code, collection_display, sub_library)
      end

      def call_number
        @call_number ||= CallNumber.new(classification, description)
      end

      def circulation_status
        @circulation_status ||= CirculationStatus.new(circulation_status_value)
      end

      def status
        @status ||= Status.new(status_code, status_display)
      end

      def processing_status
        @processing_status ||=
          ProcessingStatus.new(processing_status_code, processing_status_display)
      end

      def on_shelf?
        ON_SHELF_VALUES.include?(circulation_status.value)
      end

      def circulation_policy
        @circulation_policy ||=
          circulation_policies.find_by_identifier(circulation_policy_identifier)
      end

      private
      def rest_record_item
        @rest_record_item ||= Rest::Record::Item.new(record_id, id)
      end

      def rest_record_item_hash
        @rest_record_item_hash ||= rest_record_item.to_h['get_item']
      end

      def item
        @item ||= rest_record_item_hash['item']
      end

      def z30
        @z30 ||= item['z30']
      end

      def admin_library
        @admin_library ||= AdminLibrary.new(admin_library_code)
      end

      def sub_library
        @sub_library ||=
          SubLibrary.new(sub_library_code, sub_library_display, admin_library)
      end

      # Codes
      def admin_library_code
        @admin_library_code ||= z30['translate_change_active_library']
      end

      def sub_library_code
        @sub_library_code ||= item['z30_sub_library_code']
      end

      def collection_code
        @collection_code ||= item['z30_collection_code']
      end

      def status_code
        @status_code ||= (item['z30_item_status_code'] || '##')
      end

      def processing_status_code
        @processing_status_code ||=
          (item['z30_item_process_status_code'] || '##')
      end

      # Displays
      def sub_library_display
        @sub_library_code ||= z30['z30_sub_library']
      end

      def collection_display
        @collection_code ||= z30['z30_collection']
      end

      def status_display
        @status_display ||= z30['z30_item_status']
      end

      def processing_status_display
        @processing_status_display ||= z30['z30_item_process_status']
      end

      def classification
        @classification ||= z30['z30_call_no']
      end

      def description
        @description ||= z30['z30_description']
      end

      def circulation_status_value
        @circulation_status_value ||= item['status']
      end

      def circulation_policies
        CirculationPolicies.instance
      end

      def circulation_policy_identifier
        @circulation_policy_identifier ||=
          CirculationPolicy::Identifier.new(status, processing_status, sub_library)
      end
    end
  end
end
