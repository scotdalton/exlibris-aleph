module Exlibris
  module Aleph
    module Table
      module Reader
        module Row
          class Collections < Base
            attr_ordered_keys :code, :sub_library_code, :alpha, :display
          end
        end
      end
    end
  end
end
