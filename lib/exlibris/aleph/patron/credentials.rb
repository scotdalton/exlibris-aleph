module Exlibris
  module Aleph
    class Patron
      class Credentials
        attr_reader :id, :verification
        def initialize(id, verification=nil)
          @id = id
          @verification = verification
        end
      end
    end
  end
end
