module Exlibris
  module Aleph
    class Item
      class CallNumber
        attr_reader :classification, :description

        def initialize(classification, description)
          @classification = classification
          @description = description
        end
      end
    end
  end
end
