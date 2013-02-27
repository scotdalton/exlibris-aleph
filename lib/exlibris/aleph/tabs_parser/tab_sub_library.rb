module Exlibris
  module Aleph
    module TabParser
      class TabSubLibrary < Exlibris::Aleph::TabParser::Base

        def initialize(args)
          args[:aleph_file_name] = "tab_sub_library.eng"
          args[:pattern] = /^(.{5})\s([1-6]{1})\s(.{5})\s([L,H,A,R,S]{1})\s(.{1,30})/
          args[:pattern_key] = {
            1  => :code, 
            2  => :type, 
            3  => :library, 
            5  => :text
          }
          args[:hash_key] = :code
          super(args)
        end
      end
    end
  end
end