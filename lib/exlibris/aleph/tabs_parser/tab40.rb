module Exlibris
  module Aleph
    module TabParser
      class Tab40 < Exlibris::Aleph::TabParser::SubLibrary

        def initialize(args)
          args[:aleph_file_name] = "tab40.eng"
          args[:pattern] = /^(.{5})\s(.{5})\s(L)\s(.+)/
          args[:pattern_key] = {
            1  => :collection_code, 
            2  => :sub_library, 
            4  => :text
          }
          args[:hash_key] = :collection_code
          super(args)
        end
      end
    end
  end
end