module Exlibris
  module Aleph
    module Config
      class PcTabExpFieldExtended < Exlibris::Aleph::Config::ConfigBase

        def initialize(args)
          args[:aleph_file_name] = "pc_tab_exp_field_extended.eng"
          args[:pattern] = /^(BOR-STATUS\s{10})\s(.{5})\s(L)\s(.{50})\s([^\n]*)/
          args[:pattern_key] = {
            2  => :sublibrary, 
            4  => :text,
            5  => :code
          }
          args[:hash_key] = :code
          super(args)
        end
      end
    end
  end
end