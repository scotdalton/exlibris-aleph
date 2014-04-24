module Exlibris
  module Aleph
    module TableParser
      class ItemDisplayMasks < Base
        FILENAME = 'tab_www_item_desc.eng'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end

        def all
          rows.map { |row| Item::DisplayMask.new(row.display, row.mask) }
        end
      end
    end
  end
end
