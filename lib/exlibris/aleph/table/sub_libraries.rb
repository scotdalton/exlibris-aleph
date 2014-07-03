module Exlibris
  module Aleph
    module Table
      class SubLibraries < Base
        def all
          @all ||= Reader::SubLibraries.new.all
        end
      end
    end
  end
end
