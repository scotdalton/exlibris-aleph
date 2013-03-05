module Exlibris
  module Aleph
    module TabParser
      class Base
        attr_accessor :library, :file_name, :pattern, :pattern_key
        attr_accessor :local_path, :local_file
        attr_accessor :config_array, :config_hash, :hash_key

        def initialize(args)
          @aleph_library = args[:aleph_library]
          @aleph_library.downcase!
          @aleph_file_name = args[:aleph_file_name]
          @aleph_file_name.downcase!
          @pattern = args[:pattern]
          @pattern_key = args[:pattern_key]
          @hash_key = args[:hash_key]
          @aleph_file = "#{args[:aleph_mnt_path]}/#{@aleph_library}/tab/#{@aleph_file_name}"
        end
    
        def to_a
          @config_array ||= parse_file.first
        end
    
        def to_h
          @config_hash ||= parse_file.last
        end
    
        protected
        def parse_file
          config_array = []
          config_hash = {}
          File.open(@aleph_file).each do |line|
             line.chomp!
             config_match = line.match(@pattern)
             if (config_match)
               config_match_hash = {}
               @pattern_key.each do |column, key|
                 config_match_hash[key] = config_match[column].strip
               end
               config_array.push(config_match_hash) unless config_match_hash.empty?
               config_hash[config_match_hash[@hash_key]] = config_match_hash unless config_match_hash.empty?
             end
          end
          return [config_array, config_hash]
        end
      end
    end
  end
end