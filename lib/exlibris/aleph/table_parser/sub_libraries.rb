module Exlibris
  module Aleph
    module TableParser
      class SubLibraries < Base
        ADMIN_LIBRARY = AdminLibrary.new('alephe')
        FILENAME = 'tab_sub_library.eng'

        def initialize
          super(ADMIN_LIBRARY, FILENAME)
        end

        def rows
          @rows ||= super.reject { |row| irrelevant_codes.include?(row.code) }
        end

        def all
          rows.map do |row|
            admin_library = AdminLibrary.new(row.admin_library_code)
            SubLibrary.new(row.code, row.display, admin_library)
          end
        end

        private
        def irrelevant_codes
          @irrelevant_codes ||= Config.irrelevant_sub_libraries
        end
      end
    end
  end
end
