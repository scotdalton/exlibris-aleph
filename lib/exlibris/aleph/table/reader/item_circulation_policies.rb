module Exlibris
  module Aleph
    module Table
      module Reader
        class ItemCirculationPolicies < Base
          FILENAME = 'tab15.eng'

          def initialize(admin_library)
            super(admin_library, FILENAME)
          end

          def all
            rows.map do |row|
              sub_library = sub_libraries.find do |sub_library|
                sub_library.code == row.sub_library_code
              end
              unless sub_library.nil?
                status = Aleph::Item::Status.new(row.item_status_code)
                processing_status =
                  Aleph::Item::ProcessingStatus.new(row.item_processing_status_code)
                identifier = 
                  Aleph::Item::CirculationPolicy::Identifier.new(status, processing_status, sub_library)
                display_mask = item_display_masks[admin_library].find do |item_display_mask|
                  item_display_mask.value == row.display
                end
                mask = (display_mask.nil?) ? nil : display_mask.mask
                display = Aleph::Item::CirculationPolicy::Display.new(row.display, mask)
                privileges = Aleph::Item::CirculationPolicy::Privileges.new(row)
                Aleph::Item::CirculationPolicy.new(identifier, display, privileges)
              end
            end.compact
          end

          private
          def sub_libraries
            @sub_libraries ||= tables_manager.sub_libraries
          end

          def item_display_masks
            @item_display_masks ||= tables_manager.item_display_masks
          end

          def tables_manager
            @tables_manager ||= Aleph::TablesManager.instance
          end
        end
      end
    end
  end
end
