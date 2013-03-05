module Exlibris
  module Aleph
    module TabParser
      class Tab37 < Exlibris::Aleph::TabParser::Base

        def initialize(args)
          args[:aleph_file_name] = "tab37"
          args[:pattern] = /^(.{5})\s([0-9#]{2})\s(.{2})\s(.{2})\s([YN#])\s(.{2}.?.?.?)\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?/
          args[:pattern_key] = {
            1  => :sub_library, 
            2  => :item_status, 
            3  => :item_process_status, 
            4  => :patron_status, 
            5  => :availability_status
          }
          args[:hash_key] = :sub_library
          super(args)
        end

        protected
        def parse_file
          config_array = []
          config_hash = {}
          File.open(@aleph_file).each do |line|
            line.chomp!
            config_match = line.match(@pattern)
            if(config_match)
              config_match_hash = {}
              @pattern_key.each do |column, key|
                config_match_hash[key] = config_match[column].strip
              end
              pickup_locations = []
              (6..15).each do |column|
                pickup_locations.push(config_match[column].strip) unless config_match[column].nil?
              end
              config_match_hash[:pickup_locations] = pickup_locations
              config_array.push(config_match_hash) unless config_match_hash.empty?
              config_hash[config_match_hash[:sub_library]]={} if config_hash[config_match_hash[:sub_library]].nil?
              config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]]={} if config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]].nil?
              config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]][config_match_hash[:item_process_status]]={} if config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]][config_match_hash[:item_process_status]].nil?
              config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]][config_match_hash[:item_process_status]][config_match_hash[:patron_status]]={} if config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]][config_match_hash[:item_process_status]][config_match_hash[:patron_status]].nil?
              config_hash[config_match_hash[:sub_library]][config_match_hash[:item_status]][config_match_hash[:item_process_status]][config_match_hash[:patron_status]][config_match_hash[:availability_status]] = config_match_hash unless config_match_hash.empty? or hash_key.nil?
            else
              continuation_pattern = /^(\s{17})(.{2}.?.?.?)\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?\s?(.{5})?/
              continuation_match = line.match(continuation_pattern)
              if(continuation_match)
                continuation_match_hash = config_array.pop
                pickup_locations = continuation_match_hash[:pickup_locations]
                (2..11).each do |column|
                  pickup_locations.push(continuation_match[column].strip) unless continuation_match[column].nil?
                end
                continuation_match_hash[:pickup_locations] = pickup_locations
                config_array.push(continuation_match_hash) unless continuation_match_hash.empty?
                config_hash[continuation_match_hash[:sub_library]][continuation_match_hash[:item_status]][continuation_match_hash[:item_process_status]][continuation_match_hash[:patron_status]][continuation_match_hash[:availability_status]] = continuation_match_hash unless continuation_match_hash.empty? or hash_key.nil?
              end
            end
          end
          return [config_array, config_hash]
        end
      end
    end
  end
end