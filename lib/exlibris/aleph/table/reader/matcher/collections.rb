module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          class Collections < Base
            REGEXP = /^(.{5})\s(.{5})\s(L)\s(.+)/

            def initialize(string)
              super(REGEXP, string)
            end
          end
        end
      end
    end
  end
end
