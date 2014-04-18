module Exlibris
  module Aleph
    module TableParser
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
