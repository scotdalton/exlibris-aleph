module Exlibris
  module Aleph
    module Table
      class Collections < Base
        def all
          @all ||= begin
            Hash[
              admin_libraries.map do |admin_library|
                [admin_library, Reader::Collections.new(admin_library).all]
              end
            ]
          end
        end
      end
    end
  end
end
