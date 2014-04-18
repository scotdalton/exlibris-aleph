module Exlibris
  module Aleph
    module TableParser
      class PatronPrivileges < Base
        FILENAME = 'tab31'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end
      end
    end
  end
end
