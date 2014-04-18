module Exlibris
  module Aleph
    module TableParser
      class ItemDisplays < Base
        FILENAME = 'tab_www_item_desc.eng'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end
      end
    end
  end
end
