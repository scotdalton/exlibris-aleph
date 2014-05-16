module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          class SubLibraries < Base
            attr_ordered_keys :code, :type, :admin_library_code, :alpha, :display
          end
        end
      end
    end
  end
end
