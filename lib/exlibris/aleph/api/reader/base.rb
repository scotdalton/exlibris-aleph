module Exlibris
  module Aleph
    module API
      module Reader
        class Base
          attr_reader :root

          def initialize(root)
            @root = root
          end
        end
      end
    end
  end
end
