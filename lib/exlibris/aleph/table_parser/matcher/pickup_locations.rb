module Exlibris
  module Aleph
    module TableParser
      module Matcher
        class PickupLocations < Base
          REGEXP = /^(.{5})\s([0-9#]{2})\s(.{2})\s(.{2})\s([YN#])\s(.{2}.?.?.?)\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?/

          def initialize(string)
            super(REGEXP, string)
          end
        end
      end
    end
  end
end
