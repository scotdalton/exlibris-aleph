module Exlibris
  module Aleph
    module TableParser
      module Matcher
        class PatronStatuses < Base
          REGEXP = /^BOR-STATUS\s{10}\s.{5}\sL\s(.{50})\s(.*)$/

          def initialize(string)
            super(REGEXP, string)
          end
        end
      end
    end
  end
end
