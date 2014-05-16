module Exlibris
  module Aleph
    module API
      module Reader
        class Record < Base
          class Item < Base
            attr_reader :admin_library_code, :sub_library_code, :collection_code,
              :status_code, :processing_status_code, :sub_library_display,
              :collection_display, :status_display, :processing_status_display,
              :circulation_status_value, :classification, :description

            def initialize(root)
              super(root)
              @admin_library_code = z30['translate_change_active_library']
              @sub_library_code = item['z30_sub_library_code']
              @collection_code = item['z30_collection_code']
              @status_code = item['z30_item_status_code']
              @processing_status_code = item['z30_item_process_status_code']
              @sub_library_display= z30['z30_sub_library']
              @collection_display = z30['z30_collection']
              @status_display = z30['z30_item_status']
              @processing_status_display = z30['z30_item_process_status']
              @classification = z30['z30_call_no']
              @description = z30['z30_description']
              @circulation_status_value = item['status']
            end


            private
            def item
              @item ||= root['item']
            end

            def z30
              @z30 ||= item['z30']
            end
          end
        end
      end
    end
  end
end
