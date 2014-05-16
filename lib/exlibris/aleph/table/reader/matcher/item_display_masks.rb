module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          class ItemDisplayMasks < Base
            REGEXP = /^ITEM-STATUS    \s(.{80})\s(.*)$/

            def initialize(string)
              super(REGEXP, string)
            end
          end
        end
      end
    end
  end
end
