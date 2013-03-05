module Exlibris
  module Aleph
    module TabParser
      class TabWwwItemDesc < Exlibris::Aleph::TabParser::Base

        def initialize(args)
          args[:aleph_file_name] = "tab_www_item_desc.eng"
          args[:pattern] = /^(ITEM-STATUS    )\s(.{80})\s([^\n]*)/
          args[:pattern_key] = {
            1  => :code, 
            2  => :original_text, 
            3  => :web_text
          }
          args[:hash_key] = :original_text
          super(args)
        end
      end
    end
  end
end