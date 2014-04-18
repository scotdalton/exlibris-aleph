module Exlibris
  module Aleph
    module TableParser
      class PatronStatuses < Base
        FILENAME = 'pc_tab_exp_field_extended.eng'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end
      end
    end
  end
end
