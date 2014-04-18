module Exlibris
  module Aleph
    module Rest
      class Patron < Base
        attr_reader :id

        def initialize(id)
          @id = id
        end

        protected
        def path
          @path ||= "#{super}/patron/#{id}"
        end
      end
    end
  end
end
