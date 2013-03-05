module Exlibris
  module Aleph
    module TabParser
      class SubLibrary < Exlibris::Aleph::TabParser::Base
        def initialize(args)
          super(args)
          @aleph_sub_library_key = :sub_library
        end
    
        def to_h
          a = self.to_a
          @config_hash = {}
          sl_a = a.collect do |i|
            i[@aleph_sub_library_key]
          end
          sl_a.uniq!
          sl_a.each do |sl|
            sl_hash = {}
            a.each do |i|
              isl = i[@aleph_sub_library_key]
              if isl.strip == sl.strip
                sl_hash[i[@hash_key]] = i
              end
            end
            @config_hash["#{sl}"] = sl_hash
          end
          return @config_hash
        end
      end
    end
  end
end