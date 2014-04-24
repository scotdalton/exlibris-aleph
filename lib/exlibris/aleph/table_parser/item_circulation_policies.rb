module Exlibris
  module Aleph
    module TableParser
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
              status = Item::Status.new(row.status_code)
              processing_status =
                Item::ProcessingStatus.new(row.processing_status_code)
              identifier = 
                Item::CirculationPolicy::Identifier.new(status, processing_status, sub_library)
              display_mask = item_display_masks[admin_library].find do |item_display_mask|
                item_display_mask.value == row.display
              end
              mask = (display_mask.nil?) ? nil : display_mask.mask
              display = Item::CirculationPolicy::Display.new(row.display, mask)
              display = Item::CirculationPolicy::Display.new(row.display)
              privileges = Item::CirculationPolicy::Privileges.new(row)
              Item::CirculationPolicy.new(identifier, display, privileges)
            end
          end.compact
        end

        private
        def sub_libraries
          @sub_libraries ||= Exlibris::Aleph::SubLibraries.instance
        end
        def item_display_masks
          @item_display_masks ||= Item::DisplayMasks.instance
        end
      end
    end
  end
end
