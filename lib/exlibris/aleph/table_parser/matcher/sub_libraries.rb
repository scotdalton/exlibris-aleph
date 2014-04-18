module Exlibris
  module Aleph
    module TableParser
      module Matcher
        class SubLibraries < Base
          REGEXP = /^(.{5})\s([1-6]{1})\s(.{5})\s([L,H,A,R,S]{1})\s(.{1,30})/

          def initialize(string)
            super(REGEXP, string)
          end
        end
      end
    end
  end
end
