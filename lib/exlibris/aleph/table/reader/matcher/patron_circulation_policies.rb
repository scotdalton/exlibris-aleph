module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          class PatronCirculationPolicies < Base
            REGEXP = /^(.{5})\s([0-9#]{2})\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([CF])\s([+A])\s([DMY\s])\s([0-9]{8})\s([0-9]{10})\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YN])\s([YN])\s([YN])\s([YN])$/

            def initialize(string)
              super(REGEXP, string)
            end
          end
        end
      end
    end
  end
end
