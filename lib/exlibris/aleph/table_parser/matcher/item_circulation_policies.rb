module Exlibris
  module Aleph
    module TableParser
      module Matcher
        class ItemCirculationPolicies < Base
          REGEXP = /^(.{5})\s([0-9#]{2})\s([A-Z#]{2})\s(L)\s(.{30})\s([YN])\s([YN])\s([YNCT])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YNC])\s([AOC])/

          def initialize(string)
            super(REGEXP, string)
          end
        end
      end
    end
  end
end
