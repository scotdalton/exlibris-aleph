module Exlibris
  module Aleph
    class Patron
      class GenericStatus < Status

        def initialize
          super('##', 'Generic Status')
        end
      end
    end
  end
end
